{ callPackage, lib, nixpkgsRelease, nothing, pinnedNixpkgs, runCommand }:

with builtins;
with lib;
with rec {
  repo = getAttr "repo${removePrefix "nixpkgs" nixpkgsRelease}" pinnedNixpkgs;

  suffix = "pkgs/misc/themes/clearlooks-phenix";

  havePath = import (runCommand "have-clearlooks-phenix.nix"
    { inherit repo suffix; }
    ''
      if [[ -e "$repo/$suffix" ]]
      then
        echo true  > "$out"
      else
        echo false > "$out"
      fi
    '');

  pkg = callPackage "${repo}/${suffix}" {};
};

{
  pkg   = if havePath then pkg else nothing;
  tests = {};
}
