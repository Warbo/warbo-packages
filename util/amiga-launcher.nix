{
  buildEnv,
  fetchRawIPFS,
  fsuae,
  lib,
  makeDesktopItem,
  writeShellApplication,
}:
with rec {
  inherit (builtins) toString;
  inherit (lib) concatImapStringsSep escapeShellArg;
  floppyArg =
    n: sha256:
    "--floppy_drive_${toString (n - 1)}=${fetchRawIPFS { inherit sha256; }}";
};
{
  name,
  floppies ? [ ],
  kickstart ? fetchRawIPFS {
    sha256 = "sha256-bUOEDUCZp0Fw6g8EJbYlfDiR68qjnE0YQAdamrIrVwc=";
  },
  model ? "A1200",
}:
with rec {
  inherit (builtins) attrValues replaceStrings;
  suffixed = "${replaceStrings [ " " ] [ "" ] name}_amiga";
};
buildEnv {
  name = suffixed;
  paths = attrValues rec {
    script = writeShellApplication {
      name = suffixed;
      runtimeInputs = [ fsuae ];
      text = ''
        exec fs-uae \
          --amiga-model=${model} \
          --kickstart_file=${escapeShellArg "${kickstart}"} ${
            concatImapStringsSep " " floppyArg floppies
          }
      '';
    };

    desktop = makeDesktopItem {
      name = suffixed;
      desktopName = "${name} (Amiga)";
      comment = "${name} in an Amiga emulator";
      exec = "${script}/bin/${suffixed}";
      terminal = false;
      categories = [ "Game" ];
    };
  };
}
