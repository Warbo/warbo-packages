{ haskellOverride, nixEvalOverrides, nixpkgs1809 }:

with {
  haskellPackages = haskellOverride {
    haskellPackages = nixpkgs1809.haskell.packages.ghc7103;
    extra           = nixEvalOverrides;
  };
};
haskellPackages.runtime-arbitrary-tests
