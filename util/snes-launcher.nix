# Defines a launcher for a SNES game. Very opinionated about the emulator and
# settings.
{
  buildEnv,
  fetchRawIPFS,
  makeDesktopItem,
  mesen,
  writeShellApplication,
}:
{ name, sha256 }:
with rec {
  inherit (builtins) attrValues replaceStrings;
  suffixed = "${replaceStrings [ " " ] [ "" ] name}_snes";
};
buildEnv {
  name = suffixed;
  paths = attrValues rec {
    script = writeShellApplication {
      name = suffixed;
      runtimeInputs = [ mesen ];
      text = ''exec Mesen "$@" ${
        # Annoyingly, Mesen seems to rely on "file name extensions"
        builtins.path {
          name = "${suffixed}.sfc";
          path = fetchRawIPFS { inherit sha256; };
        }
      }'';
    };
    desktop = makeDesktopItem {
      name = suffixed;
      desktopName = "${name} (SNES)";
      comment = "${name} in a SNES emulator";
      exec = "${script}/bin/${suffixed}";
      terminal = false;
      categories = [ "Game" ];
    };
  };
}
