{ haskellOverride, nixEvalOverrides, nixpkgs1803 }:

(haskellOverride {
  haskellPackages = nixpkgs1803.haskell.packages.ghc7103;
  filepath        = true;
  extra           = nixEvalOverrides;
}).mlspec
