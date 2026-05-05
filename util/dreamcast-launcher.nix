# Creates a launcher for a Dreamcast game. Uses retroarch under the hood, and
# looks up discs using content-link. Some games need multiple discs, so we can
# accept a list of them, and create a temporary .m3u "playlist" containing all
# of them in order. We actually make temporary symlinks to each, in case the
# filename registered by content-link isn't very informative.
{ addDisc, buildEnv, content-link, lib, libretro, makeDesktopItem, writeShellApplication }:
{ name, discs }:
with rec {
  inherit (builtins)
    attrValues
    isAttrs
    isList
    replaceStrings
    ;

  inherit (lib) concatMapStringsSep;

  suffixed = "${replaceStrings [ " " ] [ "" ] name}_dreamcast";

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
        libretro.flycast
      ];
      text = ''
        set -e

        temp_dir=$(mktemp -d)
        trap 'rm -rf "$temp_dir"' EXIT

        m3u_file="$temp_dir/game.m3u"
        touch "$m3u_file"

        ${if isList discs then discList else singleDisc}

        # Can't exec, since we need the cleanup handler
        retroarch-flycast "$@" "$m3u_file"
      '';
    };

    desktop = makeDesktopItem {
      name = suffixed;
      desktopName = "${name} (Dreamcast)";
      comment = "${name} in a Dreamcast emulator";
      exec = "${script}/bin/${suffixed}";
      terminal = false;
      categories = [ "Game" ];
    };
  };
}
