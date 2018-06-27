{ callPackage, lib, nixpkgsRelease, nothing, pinnedNixpkgs, runCommand }:

with builtins;
with lib;
with rec {
  repo = getAttr "repo${removePrefix "nixpkgs" nixpkgsRelease}" pinnedNixpkgs;

  suffix = "pkgs/misc/themes/vertex";

  havePath = import (runCommand "have-vertex.nix" { inherit repo suffix; } ''
    if [[ -e "$repo/$suffix" ]]
    then
      echo true  > "$out"
    else
      echo false > "$out"
    fi
  '');

  pkg = callPackage "${repo}/${suffix}" {};
};

if havePath then pkg else nothing
