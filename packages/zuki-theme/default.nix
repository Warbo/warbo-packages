{
  callPackage,
  nothing,
  repoRelease,
  runCommand,
}:

with rec {
  suffix = "pkgs/misc/themes/zuki";

  havePath = import (
    runCommand "have-zuki.nix" { inherit repoRelease suffix; } ''
      if [[ -e "$repoRelease/$suffix" ]]
      then
        echo true  > "$out"
      else
        echo false > "$out"
      fi
    ''
  );

  pkg = callPackage "${repoRelease}/${suffix}" { };
};

if havePath then pkg else nothing
