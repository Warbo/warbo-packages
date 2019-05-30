{ nixpkgs1803, haskellOverride }:

(haskellOverride {
  haskellPackages = nixpkgs1803.haskell.packages.ghc7103;
  syb             = true;
}).lazysmallcheck2012
