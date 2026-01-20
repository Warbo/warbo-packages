# Defines a launcher for a Megadrive/Genesis game. Very opinionated about the
# emulator and settings. ROMs are identified by SHA256. We put them in the Nix
# store, since they're not very big; and fetch them from IPFS if not found.
{
  buildEnv,
  dgen-sdl,
  fetchRawIPFS,
  makeDesktopItem,
  writeShellApplication,
}:
{ name, sha256 }:
with rec {
  inherit (builtins) attrValues replaceStrings;
  suffixed = "${replaceStrings [ " " ] [ "" ] name}_megadrive";
};
buildEnv {
  name = suffixed;
  paths = attrValues rec {
    script = writeShellApplication {
      name = suffixed;
      runtimeInputs = [ dgen-sdl ];
      text = ''exec dgen "$@" ${fetchRawIPFS { inherit sha256; }}'';
    };

    desktop = makeDesktopItem {
      name = suffixed;
      desktopName = "${name} (MegaDrive)";
      comment = "${name} in a MegaDrive emulator";
      exec = "${script}/bin/${suffixed}";
      terminal = false;
      categories = [ "Game" ];
    };
  };
}
