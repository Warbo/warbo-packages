{ haskellOverride, nixpkgs1609 }:

{
  pkg = (haskellOverride {
    haskellPackages = nixpkgs1609.haskellPackages;
    panPkgs         = true;
  }).panpipe;

  tests = {};
}
