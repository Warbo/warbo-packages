{ die, haskell, haskellOverride, lib }:

with lib;
with {
  haskellPackages = haskellOverride {
  haskellPackages = haskell.packages.ghc7103;
    extra           = nixEvalOverrides;
  };
};
haskellPackages.nix-eval
