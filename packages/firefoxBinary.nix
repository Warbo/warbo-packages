# Firefox binary downloaded from Mozilla and installed into an FHS environment
{ buildFHSUserEnv, cacert, fetchurl, lib, runCommand, unpack, wget }:

with builtins;
with lib;
with rec {
  latest = import (runCommand "latest-firefox-version.nix"
    {
      __noChroot    = true;
      buildInputs   = [ wget ];
      url           = https://www.mozilla.org/en-US/firefox/releases;
      SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";
    }
    ''
      wget -O- "$url" | grep -o 'data-latest-firefox="[^"]*"' |
                        grep -o '".*"' > "$out"
    '');

  version = "67.0";

  warn = if compareVersions version latest == -1
            then trace (toJSON {
                   inherit latest version;
                   WARNING = "Newer Firefox is out";
                 })
            else (x: x);

  url = warn concatStrings [
    "https://archive.mozilla.org/pub/firefox/releases/"
    version
    "/linux-i686/en-GB/firefox-"
    version
    ".tar.bz2"
  ];

  contents = unpack (fetchurl {
    inherit url;
    sha256 = "0msgm3n5lp2fmhplhjbccz32s2wl0b4iwf8r8zwmpjwkrasy5407";
  });

  raw = runCommand "firefoxBinary-${version}" { inherit contents; } ''
    mkdir -p "$out/bin"
    ln -s "$contents/firefox" "$out/bin/firefox"
  '';

  pkg = buildFHSUserEnv {
    name       = "firefox";
    targetPkgs = pkgs: [ raw ] ++ (with pkgs; with xorg; [
      # These are copypasta from the nixpkgs firefox dependencies
      alsaLib
      atk
      cairo
      cups
      dbus-glib
      dbus
      fontconfig
      freetype
      gdk_pixbuf
      glib
      glibc
      gtk2
      gtk3
      kerberos
      libX11
      libXScrnSaver
      libXcomposite
      libXcursor
      libxcb
      libXdamage
      libXext
      libXfixes
      libXi
      libXinerama
      libXrender
      libXt
      libcanberra-gtk2
      libnotify
      libGLU_combined
      nspr
      nss
      pango
      libheimdal
      libpulseaudio
      (lib.getDev libpulseaudio)
      ffmpeg
    ]);
    runScript  = "firefox";
  };
};
{
  inherit pkg;

  tests = {};
}
