{ haskell, haskellOverride }:

(haskellOverride {
  haskellPackages = haskell.packages.ghc7103;
  filepath        = true;
}).mlspec-helper
