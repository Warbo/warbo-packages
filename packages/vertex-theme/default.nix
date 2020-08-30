{ callPackage, nothing, repoRelease, runCommand }:

with rec {
  suffix = "pkgs/misc/themes/vertex";

  havePath = import (runCommand "have-vertex.nix"
    { inherit repoRelease suffix; }
    ''
      if [[ -e "$repoRelease/$suffix" ]]
      then
        echo true  > "$out"
      else
        echo false > "$out"
      fi
    '');

  pkg = callPackage "${repoRelease}/${suffix}" {};
};

{
  pkg   = if havePath then pkg else nothing;
  tests = {};
}
