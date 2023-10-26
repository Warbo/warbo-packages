{ callPackage, nothing, repoRelease, runCommand }:

with rec {
  suffix = "pkgs/misc/themes/clearlooks-phenix";

  havePath = import
    (runCommand "have-clearlooks-phenix.nix" { inherit repoRelease suffix; } ''
      if [[ -e "$repoRelease/$suffix" ]]
      then
        echo true  > "$out"
      else
        echo false > "$out"
      fi
    '');

  pkg = callPackage "${repoRelease}/${suffix}" { };
};

if havePath then pkg else nothing
