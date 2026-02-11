{
  buildFHSEnv,
  fetchRawIPFS,
  nixpkgs,
  runCommand,
}:
with rec {
  bios = fetchRawIPFS {
    sha256 = "sha256-ca+U0eR6aMEej9ufg2gEBgFRSkKlo5nNpIx9O/8emdM=";
  };

  psx-unwrapped =
    runCommand "pSX-unwrapped"
      {
        psx = fetchRawIPFS {
          sha256 = "sha256-+tsTgmxe1C4iMeVo7qiaO6vzTCO/EpSFZZ8qZ+mJZAU=";
        };
      }
      ''
        tar xjf "$psx"
        mkdir -p "$out/lib/pSX"
        cp -r pSX/* "$out/lib/pSX/"
        chmod +x "$out/lib/pSX/pSX"
        cp ${bios} "$out/lib/pSX/bios/scph1001.bin"
      '';

  # pSX is a 32-bit binary that needs several libraries no longer available in
  # modern nixpkgs. We build thin shim/stub libraries to bridge the gaps:
  #
  #   libpangox-1.0.so.0 - pSX links it but calls no pangox-specific symbols;
  #                         pangox-compat doesn't compile against modern pango,
  #                         so a stub .so satisfies the dynamic linker.
  #
  #   libxml2.so.2       - pSX expects the old soname but modern libxml2
  #                         ships libxml2.so.16. A shim with the old soname
  #                         dlopen()s the real library at load time.
  compatLibs =
    pkgs:
    pkgs.stdenv.mkDerivation {
      pname = "psx-compat-libs";
      version = "0.1";
      dontUnpack = true;
      buildPhase = ''
        # pangox stub
        echo 'void __pangox_stub(void) {}' > pangox_stub.c
        $CC -shared -fPIC pangox_stub.c \
          -Wl,-soname,libpangox-1.0.so.0 \
          -o libpangox-1.0.so.0

        # libxml2 compat shim
        cat > xml2_shim.c << 'CEOF'
        #define _GNU_SOURCE
        #include <dlfcn.h>
        __attribute__((constructor)) static void load_real_xml2(void) {
          dlopen("${pkgs.libxml2.out}/lib/libxml2.so", RTLD_NOW | RTLD_GLOBAL);
        }
        CEOF
        $CC -shared -fPIC xml2_shim.c \
          -Wl,-soname,libxml2.so.2 \
          -ldl \
          -o libxml2.so.2
      '';
      installPhase = ''
        mkdir -p $out/lib
        cp libpangox-1.0.so.0 libxml2.so.2 $out/lib/
      '';
    };

  # Use the pkgs argument so multiPkgs receives proper i686 versions
  deps =
    pkgs: with pkgs; [
      alsa-lib
      atk
      cairo
      (compatLibs pkgs)
      gdk-pixbuf
      glib
      gnome2.gtkglext
      gnome2.libglade
      gtk2
      libGL
      libGLU
      libxml2
      pango
      pipewire
      stdenv.cc.cc.lib
      xorg.libICE
      xorg.libSM
      xorg.libX11
      xorg.libXmu
      xorg.libXt
      zlib
    ];

  compat32 = compatLibs nixpkgs.pkgsi686Linux;

  # The host NixOS ALSA config (/etc/alsa/conf.d/49-pipewire-modules.conf)
  # hardcodes the 64-bit pipewire ALSA plugin path in `libs.native`.  When the
  # 32-bit pSX binary loads ALSA it reads that same config and tries to dlopen
  # the 64-bit .so, which fails.  We build a corrected conf.d directory that
  # points `libs.native` at the 32-bit pipewire ALSA plugins instead, and
  # bind-mount it over the host's /etc/alsa/conf.d inside the FHS sandbox.
  pipewire32 = nixpkgs.pkgsi686Linux.pipewire;
  alsaEtcDir = runCommand "psx-etc-alsa" { } ''
    mkdir -p $out/conf.d
    # Copy all host-like conf.d files from the 64-bit pipewire, then override
    # the modules config with 32-bit paths.
    for f in ${nixpkgs.pipewire}/share/alsa/alsa.conf.d/*.conf; do
      cp "$f" "$out/conf.d/$(basename "$f")"
    done
    cat > "$out/conf.d/49-pipewire-modules.conf" << 'EOF'
    pcm_type.pipewire {
      libs.native = ${pipewire32}/lib/alsa-lib/libasound_module_pcm_pipewire.so ;
    }
    ctl_type.pipewire {
      libs.native = ${pipewire32}/lib/alsa-lib/libasound_module_ctl_pipewire.so ;
    }
    EOF
  '';
};
buildFHSEnv {
  name = "pSX";
  multiArch = true;
  targetPkgs = deps;
  multiPkgs = deps;
  # Compat libs must appear on LD_LIBRARY_PATH so the dynamic linker finds
  # them before ldconfig's cache (which won't index our custom sonames).
  profile = ''
    export LD_LIBRARY_PATH=${compat32}/lib:$LD_LIBRARY_PATH
  '';
  # Place the corrected ALSA config in the FHS rootfs's /etc/alsa so it takes
  # priority over the host's (the bwrap wrapper skips host /etc entries that
  # already exist in the rootfs).
  extraBuildCommands = ''
    mkdir -p $out/etc/alsa
    cp -r ${alsaEtcDir}/conf.d $out/etc/alsa/
  '';
  runScript = "${psx-unwrapped}/lib/pSX/pSX";
}
// {
  inherit psx-unwrapped;
}
