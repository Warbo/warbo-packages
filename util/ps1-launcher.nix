# Creates a launcher for a PlayStation 1 game. Uses retroarch under the hood,
# and looks up discs using content-link. Some games need multiple discs, so we
# can accept a list of them, and create a temporary .m3u "playlist" containing
# all of them in order. We actually make temporary symlinks to each, in case the
# filename registered by content-link isn't very informative.
{
  buildEnv,
  content-link,
  lib,
  libretro,
  makeDesktopItem,
  writeShellApplication,
}:
{ name, discs }:
with rec {
  inherit (builtins)
    attrNames
    attrValues
    head
    isAttrs
    isList
    length
    replaceStrings
    ;
  inherit (lib) concatMapStringsSep escapeShellArg;
  suffixed = "${replaceStrings [ " " ] [ "" ] name}_ps1";

  # Extends the launcher script to look up this disc in content-link, symlink to
  # it, and add that symlink to the .m3u given to the emulator.
  addDisc =
    disc:
    assert
      length (attrNames disc) == 1
      || abort ''Each disc should be a single {name: hash} attrset'';
    with rec {
      label = head (attrNames disc);
      hash = head (attrValues disc);
      link = escapeShellArg (replaceStrings [ " " "/" ] [ "_" "_" ] label);
    };
    ''
      LOC=$(content-link get ${escapeShellArg hash}) || {
        echo "content-link registry does not contain ${label}"
        exit 1
      } 1>&2
      ln -s "$LOC" "$temp_dir"/${link}
      printf '%s\n' ${link} >> "$m3u_file"
    '';

  discList = assert isList discs; concatMapStringsSep "\n" addDisc discs;

  singleDisc = assert isAttrs discs; addDisc discs;
};
buildEnv {
  name = suffixed;
  paths = attrValues rec {
    script = writeShellApplication {
      name = suffixed;
      runtimeInputs = [
        content-link
        libretro.pcsx-rearmed
      ];
      text = ''
        set -e
        temp_dir=$(mktemp -d)
        trap 'rm -rf "$temp_dir"' EXIT

        m3u_file="$temp_dir/game.m3u"
        touch "$m3u_file"

        ${if isList discs then discList else singleDisc}

        # Can't exec, since we need the cleanup handler
        retroarch-pcsx-rearmed "$@" "$m3u_file"
      '';
    };

    desktop = makeDesktopItem {
      name = suffixed;
      desktopName = "${name} (PS1)";
      comment = "${name} in a PlayStation emulator";
      exec = "${script}/bin/${suffixed}";
      terminal = false;
      categories = [ "Game" ];
    };
  };
}
