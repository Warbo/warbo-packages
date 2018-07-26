{ composeAll, haskellOverride, nixpkgs1609, panPkgs }:

(nixpkgs1609.haskellPackages.override (old: {
  overrides = composeAll (old.overrides or (_: _: {})) [
    panPkgs
    haskellOverride
  ];
})).panhandle
