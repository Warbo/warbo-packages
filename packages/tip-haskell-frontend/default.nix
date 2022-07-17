{ warboHaskellOverride, nixpkgs1709 }:

(warboHaskellOverride {
  haskellPackages = nixpkgs1709.haskell.packages.ghc784;
}).tip-haskell-frontend or null
