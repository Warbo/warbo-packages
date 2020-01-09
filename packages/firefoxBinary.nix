# Firefox binary downloaded from Mozilla and installed into an FHS environment
{ bash, buildFHSUserEnv, cacert, fail, fetchurl, gnome2, gnome3,
  gsettings-desktop-schemas, gtk3, hicolor-icon-theme, lib, makeFontsConf,
  mkBin, onlineCheck, runCommand, unpack, wget }:

with builtins;
with lib;
with rec {
  # Update these as needed
  version = "72.0.1";
  sha256  = "07x9np78lb8pcwljdbvxf4svds7kc2m9gmzqkhn7g7macq5ryymh";

  latest = import (runCommand "latest-firefox-version.nix"
    {
      __noChroot    = true;
      buildInputs   = [ wget ];
      cacheBuster   = toString currentTime;
      url           = https://www.mozilla.org/en-US/firefox/releases;
      SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";
    }
    ''
      wget -q -O- "$url" | grep -o 'data-latest-firefox="[^"]*"' |
                           grep -o '".*"' > "$out"
    '');

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

  contents = unpack (fetchurl { inherit sha256 url; });

  raw = mkBin {
    name   = "firefoxWrapper";
    paths  = [ bash fail ];
    vars   = {
      inherit contents;

      # Avoid "Locale not supported by C library"
      LANG   = "C";
      LOCALE = "C";

      # Avoid Fontconfig error: Cannot load default config file
      FONTCONFIG_FILE = makeFontsConf { fontDirectories = []; };
    };
    script = ''
      #!${bash}/bin/bash
      set -e

      # Make gsettings schemas available, to avoid file dialogues crashing
      function addSchemas {
        FOUND=0
        for D in "$1"*
        do
          FOUND=1
          export XDG_DATA_DIRS="$D:$XDG_DATA_DIRS"
        done
        [[ "$FOUND" -eq 1 ]] || fail "No schemas found for '$1'"
      }
      addSchemas "${gsettings-desktop-schemas.out
                  }/share/gsettings-schemas/gsettings-desktop-schemas-"
      addSchemas "${gtk3.out}/share/gsettings-schemas/gtk"

      # Make GTK icons, etc. available
      export XDG_DATA_DIRS="${concatStringsSep ":" [
        "${gnome3.adwaita-icon-theme}/share"
        "${gnome2.gnome_icon_theme}/share"
        "${hicolor-icon-theme}/share"
        "$XDG_DATA_DIRS"
      ]}"

      exec "$contents/firefox" "$@"
    '';
  };

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

      # Required for glib schemas; without this, file dialogue boxen will crash
      gnome3.dconf

      # Avoid 'The 'hicolor' theme was not found'
      hicolor-icon-theme
      gnome2.gnome_icon_theme
      gnome3.adwaita-icon-theme
    ]);
    runScript = "firefoxWrapper";
  };
};
{
  inherit pkg;

  tests = {};
}
