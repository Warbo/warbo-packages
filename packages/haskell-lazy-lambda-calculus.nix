{ haskellOverride, nixpkgs1803 }:

(haskellOverride {
  haskellPackages = nixpkgs1803.haskell.packages.ghc7103;
  syb             = true;
}).lazy-lambda-calculus
