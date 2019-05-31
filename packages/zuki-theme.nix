{ callPackage, nixpkgsRelease, nothing, pinnedNixpkgs, runCommand }:

with builtins;
with rec {
  repo = pinnedNixpkgs."repo${nixpkgsRelease}" or
         (trace (toJSON {
           warning = ''
             pinnedNixpkgs doesn't contain a repo for current nixpkgs version,
             falling back to 18.03.
           '';
           available = attrNames pinnedNixpkgs;
         })
         pinnedNixpkgs.repo1803);

  suffix = "pkgs/misc/themes/zuki";

  havePath = import (runCommand "have-zuki.nix" { inherit repo suffix; } ''
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
