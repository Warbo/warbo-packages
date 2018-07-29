{ haskell, haskellOverride, nixEvalOverrides }:

(haskellOverride {
  haskellPackages = haskell.packages.ghc7103;
  extra           = nixEvalOverrides;
}).nix-eval
