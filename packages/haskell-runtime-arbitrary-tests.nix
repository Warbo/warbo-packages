{ haskellOverride, nixEvalOverrides, nixpkgs1803 }:

with {
  haskellPackages = haskellOverride {
    haskellPackages = nixpkgs1803.haskell.packages.ghc7103;
    extra           = nixEvalOverrides;
  };
};
haskellPackages.runtime-arbitrary-tests
