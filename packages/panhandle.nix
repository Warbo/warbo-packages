{ haskellOverride, nixpkgs1609 }:

(haskellOverride {
  haskellPackages = nixpkgs1609.haskell.packages.ghc7103;
  panPkgs         = true;
}).panhandle
