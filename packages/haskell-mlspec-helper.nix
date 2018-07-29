{ haskell, haskellOverride, nixEvalOverrides }:

(haskellOverride {
  haskellPackages = haskell.packages.ghc7103;
  filepath        = true;
  extra           = nixEvalOverrides;
}).mlspec-helper
