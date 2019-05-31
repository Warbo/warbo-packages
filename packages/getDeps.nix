{ haskellOverride, nixpkgs1803 }:

{
  pkg = (haskellOverride {
    haskellPackages = nixpkgs1803.haskell.packages.ghc7103;
    filepath        = true;
  }).getDeps;

  tests = {};
}
