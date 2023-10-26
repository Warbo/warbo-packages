# Firefox binary downloaded from Mozilla and installed into an FHS environment
{ bash, buildFHSUserEnv, fail, gnome2, gnome3, gsettings-desktop-schemas, gtk3
, hicolor-icon-theme, lib, makeFontsConf, mkBin, onlineCheck, runCommand
, unpack' }:

with builtins;
with lib;
with rec {
  raw = source:
    mkBin {
      name = "firefoxWrapper-${source.version}";
      paths = [ bash fail ];
      vars = {
        contents = unpack' "firefox-source-${source.version}" source.outPath;

        # Avoid "Locale not supported by C library"
        LANG = "C";
        LOCALE = "C";

        # Avoid Fontconfig error: Cannot load default config file
        FONTCONFIG_FILE = makeFontsConf { fontDirectories = [ ]; };
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
        addSchemas "${gsettings-desktop-schemas.out}/share/gsettings-schemas/gsettings-desktop-schemas-"
        addSchemas "${gtk3.out}/share/gsettings-schemas/gtk"

        # Make GTK icons, etc. available
        export XDG_DATA_DIRS="${
          concatStringsSep ":" [
            "${gnome3.adwaita-icon-theme}/share"
            "${gnome2.gnome_icon_theme}/share"
            "${hicolor-icon-theme}/share"
            "$XDG_DATA_DIRS"
          ]
        }"

        exec "$contents/firefox" "$@"
      '';
    };
};
source:
buildFHSUserEnv {
  name = "firefox";
  targetPkgs = pkgs:
    [ (raw source) ] ++

    # Nixpkgs versions differ in how they define these libraries
    (optional (hasAttr "libGL" pkgs) pkgs.libGL)
    ++ (optional (hasAttr "libGLU" pkgs) pkgs.libGLU)
    ++ (optional (hasAttr "libGLU_combined" pkgs) pkgs.libGLU_combined) ++

    (with pkgs;
      with xorg; [
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
  runScript = "firefoxWrapper-${source.version}";
}
