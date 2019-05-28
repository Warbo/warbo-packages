{ haskellOverride, nixEvalOverrides, nixpkgs1809 }:

(haskellOverride {
  haskellPackages = nixpkgs1809.haskell.packages.ghc7103;
  filepath        = true;
  extra           = nixEvalOverrides;
}).mlspec-helper
