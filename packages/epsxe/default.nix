{
  autoPatchelfHook,
  buildFHSEnv,
  fetchurl,
  makeWrapper,
  runCommand,
  unzip,

  # Library dependencies
  ncurses5,
  zlib,
  libGL,
  alsa-lib,
  xorg,
  curl,
  openssl_1_1,
  gtk3,
  gdk-pixbuf,
  glib,
  SDL,
  SDL_ttf,
  stdenv,
}:
with rec {
  # Silence warning about insecure openssl; use .out for the library output
  old_openssl = (openssl_1_1.overrideAttrs { meta = { }; }).out;

  # ePSXe was built against very old libraries and needs specific ELF symbol
  # versions that no longer match current nixpkgs packages:
  #
  #   libncurses.so.5    -> NCURSES_5.0.19991023     (have NCURSESW_*)
  #   libcurl.so.4       -> CURL_OPENSSL_3            (have CURL_OPENSSL_4)
  #   libcrypto.so.1.0.0 -> OPENSSL_1.0.0            (have OPENSSL_1.1.0)
  #
  # We create thin shim libraries that define the old version symbols and
  # forward calls to the real (newer) libraries via dlopen/dlsym using their
  # absolute Nix store paths (to avoid circular soname resolution).
  compat-libs = stdenv.mkDerivation {
    name = "epsxe-compat-libs";

    dontUnpack = true;

    buildInputs = [
      ncurses5
      curl
      old_openssl
    ];

    buildPhase = ''
      # --- libncurses.so.5 shim (needs NCURSES_5.0.19991023) ---
      cat > ncurses_shim.c << 'CEOF'
      #define _GNU_SOURCE
      #include <dlfcn.h>
      #include <stdlib.h>

      typedef void WINDOW;

      static void *real_lib = NULL;
      static void ensure_loaded(void) {
        if (!real_lib) {
          real_lib = dlopen("${ncurses5}/lib/libncursesw.so.5", RTLD_NOW | RTLD_GLOBAL);
          if (!real_lib) { abort(); }
        }
      }

      int wgetch(WINDOW *win) {
        ensure_loaded();
        int (*real)(WINDOW*) = dlsym(real_lib, "wgetch");
        return real(win);
      }
      CEOF

      cat > ncurses.map << 'EOF'
      NCURSES_5.0.19991023 {
        global: wgetch;
        local: *;
      };
      EOF

      gcc -shared -fPIC ncurses_shim.c \
        -Wl,--version-script=ncurses.map \
        -Wl,-soname,libncurses.so.5 \
        -ldl \
        -o libncurses.so.5

      # --- libcurl.so.4 shim (needs CURL_OPENSSL_3) ---
      cat > curl_shim.c << 'CEOF'
      #define _GNU_SOURCE
      #include <dlfcn.h>
      #include <stdarg.h>
      #include <stdlib.h>

      typedef void CURL;
      typedef int CURLcode;
      typedef int CURLoption;

      static void *real_lib = NULL;
      static void ensure_loaded(void) {
        if (!real_lib) {
          real_lib = dlopen("${curl.out}/lib/libcurl.so.4", RTLD_NOW | RTLD_GLOBAL);
          if (!real_lib) { abort(); }
        }
      }

      CURLcode curl_easy_perform(CURL *c) {
        ensure_loaded();
        CURLcode (*real)(CURL*) = dlsym(real_lib, "curl_easy_perform");
        return real(c);
      }
      CURLcode curl_easy_setopt(CURL *c, CURLoption o, ...) {
        ensure_loaded();
        CURLcode (*real)(CURL*, CURLoption, ...) = dlsym(real_lib, "curl_easy_setopt");
        va_list ap; va_start(ap, o); void *p = va_arg(ap, void*); va_end(ap);
        CURLcode r = real(c, o, p);
        va_end(ap);
        return r;
      }
      CURL *curl_easy_init(void) {
        ensure_loaded();
        CURL* (*real)(void) = dlsym(real_lib, "curl_easy_init");
        return real();
      }
      void curl_easy_cleanup(CURL *c) {
        ensure_loaded();
        void (*real)(CURL*) = dlsym(real_lib, "curl_easy_cleanup");
        real(c);
      }
      CEOF

      cat > curl.map << 'EOF'
      CURL_OPENSSL_3 {
        global: curl_easy_perform; curl_easy_setopt; curl_easy_init; curl_easy_cleanup;
        local: *;
      };
      EOF

      gcc -shared -fPIC curl_shim.c \
        -Wl,--version-script=curl.map \
        -Wl,-soname,libcurl.so.4 \
        -ldl \
        -o libcurl.so.4

      # --- libcrypto.so.1.0.0 shim (needs OPENSSL_1.0.0) ---
      cat > crypto_shim.c << 'CEOF'
      #define _GNU_SOURCE
      #include <dlfcn.h>
      #include <stdlib.h>
      #include <stddef.h>

      // Opaque MD5_CTX – we just forward the pointer
      typedef void MD5_CTX;

      static void *real_lib = NULL;
      static void ensure_loaded(void) {
        if (!real_lib) {
          real_lib = dlopen("${old_openssl}/lib/libcrypto.so.1.1", RTLD_NOW | RTLD_GLOBAL);
          if (!real_lib) { abort(); }
        }
      }

      int MD5_Init(MD5_CTX *c) {
        ensure_loaded();
        int (*real)(MD5_CTX*) = dlsym(real_lib, "MD5_Init");
        return real(c);
      }
      int MD5_Update(MD5_CTX *c, const void *d, size_t l) {
        ensure_loaded();
        int (*real)(MD5_CTX*, const void*, size_t) = dlsym(real_lib, "MD5_Update");
        return real(c, d, l);
      }
      int MD5_Final(unsigned char *md, MD5_CTX *c) {
        ensure_loaded();
        int (*real)(unsigned char*, MD5_CTX*) = dlsym(real_lib, "MD5_Final");
        return real(md, c);
      }
      CEOF

      cat > crypto.map << 'EOF'
      OPENSSL_1.0.0 {
        global: MD5_Init; MD5_Update; MD5_Final;
        local: *;
      };
      EOF

      gcc -shared -fPIC crypto_shim.c \
        -Wl,--version-script=crypto.map \
        -Wl,-soname,libcrypto.so.1.0.0 \
        -ldl \
        -o libcrypto.so.1.0.0
    '';

    installPhase = ''
      mkdir -p $out/lib
      cp libncurses.so.5 libcurl.so.4 libcrypto.so.1.0.0 $out/lib/
    '';
  };
};
buildFHSEnv {
  name = "epsxe";
  targetPkgs = pkgs: [
    pkgs.ncurses5
    pkgs.zlib
    pkgs.libGL
    pkgs.alsa-lib
    pkgs.xorg.libX11
    pkgs.curl
    (pkgs.openssl_1_1.overrideAttrs { meta = { }; })
    compat-libs
    pkgs.gtk3
    pkgs.gdk-pixbuf
    pkgs.glib
    pkgs.SDL
    pkgs.SDL_ttf
    pkgs.stdenv.cc.cc.lib
  ];
  multiPkgs = pkgs: [
    pkgs.ncurses5
    pkgs.zlib
    pkgs.libGL
    pkgs.alsa-lib
    pkgs.xorg.libX11
    pkgs.curl
    (pkgs.openssl_1_1.overrideAttrs { meta = { }; })
    compat-libs
    pkgs.gtk3
    pkgs.gdk-pixbuf
    pkgs.glib
    pkgs.SDL
    pkgs.SDL_ttf
    pkgs.stdenv.cc.cc.lib
  ];
  profile = ''
    # Our compat shim libraries must be found BEFORE the FHS /usr/lib64 copies,
    # since those lack the old ELF version symbols ePSXe expects.  The compat
    # libs live in the Nix store which is bind-mounted into the FHS sandbox.
    export LD_LIBRARY_PATH=${compat-libs}/lib:/usr/lib64:/usr/lib32:/usr/lib:$LD_LIBRARY_PATH
  '';
  runScript = "${
    runCommand "epsxe"
      {
        buildInputs = [ unzip ];
        epsxe = fetchurl {
          url = "https://www.epsxe.com/files/ePSXe205linux_x64.zip";
          sha256 = "sha256-YKmdtfQAMovr4KlyyupiBtGiTVmgkiSMC1/BLhhOypk=";
        };
      }
      ''
        mkdir -p "$out/bin"
        unzip "$epsxe"
        BIN="$out/bin/epsxe"
        mv epsxe_x64 "$BIN"
        chmod +x "$BIN"
      ''
  }/bin/epsxe";
}
