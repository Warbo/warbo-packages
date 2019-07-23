# Firefox binary downloaded from Mozilla and installed into an FHS environment
{ buildFHSUserEnv, cacert, fetchurl, lib, onlineCheck, runCommand, unpack,
  wget }:

with builtins;
with lib;
with rec {
  latest = import (runCommand "latest-firefox-version.nix"
    {
      __noChroot    = true;
      buildInputs   = [ wget ];
      cacheBuster   = toString currentTime;
      url           = https://www.mozilla.org/en-US/firefox/releases;
      SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";
    }
    ''
      wget -O- "$url" | grep -o 'data-latest-firefox="[^"]*"' |
                        grep -o '".*"' > "$out"
    '');

  version = "68.0.1";

  warn = if onlineCheck && compareVersions version latest == -1
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
    sha256 = "1z61lfdbkrkgcd6mbncvc517fmky7cjq0jc5ccycqahvy6zy8x48";
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
