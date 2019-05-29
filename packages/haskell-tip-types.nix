{ haskellOverride, nixpkgs1809 }:

(haskellOverride {
  haskellPackages = nixpkgs1809.haskell.packages.ghc7103;
}).tip-types
