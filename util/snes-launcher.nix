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
buildEnv {
  inherit name;
  paths = builtins.attrValues rec {
    script = writeShellApplication {
      name = "${name}_snes";
      runtimeInputs = [ mesen ];
      text = ''exec Mesen "$@" ${
        # Annoyingly, Mesen seems to rely on "file name extensions"
        builtins.path {
          #inherit sha256;
          name = "${name}.sfc";
          path = fetchRawIPFS { inherit sha256; };
        }
      }'';
    };
    desktop = makeDesktopItem {
      inherit name;
      desktopName = "${name} (SNES)";
      comment = "${name} in a SNES emulator";
      exec = "${script}/bin/${name}_snes";
      terminal = false;
      categories = [ "Game" ];
    };
  };
}
