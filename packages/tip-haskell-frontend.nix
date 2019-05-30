{ haskellOverride, nixpkgs1709 }:

(haskellOverride {
  haskellPackages = nixpkgs1709.haskell.packages.ghc784;
}).tip-haskell-frontend
