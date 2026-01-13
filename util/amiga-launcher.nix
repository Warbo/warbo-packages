{
  amiberry,
  buildEnv,
  fetchRawIPFS,
  lib,
  makeDesktopItem,
  writeShellApplication,
}:
with rec {
  inherit (builtins) toString;
  inherit (lib) concatImapStringsSep escapeShellArg;
  floppyArg =
    n: sha256: "-${toString (n - 1)} ${fetchRawIPFS { inherit sha256; }}";
};
{
  name,
  floppies ? [ ],
  kickstart ? fetchRawIPFS {
    sha256 = "sha256-bUOEDUCZp0Fw6g8EJbYlfDiR68qjnE0YQAdamrIrVwc=";
  },
  model ? "A1200",
}:
buildEnv {
  inherit name;
  paths = builtins.attrValues rec {
    script = writeShellApplication {
      inherit name;
      runtimeInputs = [ amiberry ];
      text = ''
        exec amiberry --model ${escapeShellArg model} \
          -r ${escapeShellArg "${kickstart}"} \
          -G ${concatImapStringsSep " " floppyArg floppies}
      '';
    };

    desktop = makeDesktopItem {
      inherit name;
      desktopName = "${name} (Amiga)";
      comment = "${name} in an Amiga emulator";
      exec = "${script}/bin/${name}";
      terminal = false;
      categories = [ "Game" ];
    };
  };
}
