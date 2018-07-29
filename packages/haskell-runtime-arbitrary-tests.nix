{ haskell, haskellOverride, nixEvalOverrides }:

with {
  haskellPackages = haskellOverride {
    haskellPackages = haskell.packages.ghc7103;
    extra           = nixEvalOverrides;
  };
};
haskellPackages.runtime-arbitrary-tests
