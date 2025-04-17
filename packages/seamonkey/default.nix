{ comm ? builtins.fetchGit
  ({
    url = "https://gitlab.com/seamonkey-project/seamonkey-2.53-comm.git";
  } // comm-rev)
, comm-rev ?
  {
    rev = "f135d4bd4f97466808982b5e7cde07a0efb3a280";
    narHash = "sha256-3M1JSucU8JcyCtYE6XZSQ4V4EbNEQXl7SG+Q4NmtMrI=";
  }
, mozilla ? builtins.fetchGit
  ({
    url = "https://gitlab.com/seamonkey-project/seamonkey-2.53-mozilla";
  } // mozilla-rev)
, mozilla-rev ?
  {
    rev = "71b78e662b44db2a6a794ef55b8541d53bbc16fd";
    narHash = "sha256-TsI0hYZkAMxImc7KPwBn8taUU02EnqRXC/XW7w4WXJo=";
  }
, mozconfig ? builtins.toFile "mozconfig"
  ''
    export CC=clang
    export CXX=clang++
    ac_add_options --enable-application=comm/suite
    ac_add_options --enable-calendar
    ac_add_options --enable-irc
    ac_add_options --enable-dominspector
    mk_add_options MOZ_OBJDIR=REPLACE
    ac_add_options --enable-optimize
    ac_add_options --enable-js-shell
    ac_add_options --enable-elf-hack
    ac_add_options --disable-debug-symbols
    ac_add_options --disable-tests

    # Disable checking that add-ons are signed by the trusted root
    MOZ_ADDON_SIGNING=0
    # Disable enforcing that add-ons are signed by the trusted root
    MOZ_REQUIRE_SIGNING=0

    # Package js shell
    export MOZ_PACKAGE_JSSHELL=1
  ''
, runCommand
, buildInputs ? [ autoconf cargo pyEnv nasm clang gcc rustc unzip zip
                  alsa-lib dbus-glib gnome2.GConf gtk3 libXt pulseaudio.dev
                  yasm pkg-config rust-cbindgen libllvm ] ++ extraDeps
, extraDeps ? []
, pyEnv ? (python311.withPackages pyPackages)
, pyPackages ?
  (python3Packages: [
    #(mach.override { inherit python3Packages; }).lib
    #python3Packages.blessed
    #'mozfile',
    #'mozprocess',
    #python3Packages.six
  ])
, autoconf, cargo, python311, nasm, clang, gcc, rustc, unzip, zip, alsa-lib
, dbus-glib, gnome2, gtk3, libXt, pulseaudio, yasm, mach, pkg-config
, rust-cbindgen, libllvm
}:
runCommand "seamonkey"
  { inherit buildInputs comm mozconfig mozilla; }
  ''
    export HOME="$PWD"
    mkdir mozilla
    cd mozilla
    for X in "$mozilla"/*
    do
      ln -s "$X" "./$(basename "$X")"
    done
    ln -s "$comm" comm
    sed -e "s@MOZ_OBJDIR=REPLACE@MOZ_OBJDIR=$PWD/obj-seamonkey@g" \
      < "$mozconfig" > .mozconfig
    export MACH_USE_SYSTEM_PYTHON=1
    ./mach build
  ''
