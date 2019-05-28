{ nixpkgs1809, haskellOverride }:

(haskellOverride {
  haskellPackages = nixpkgs1809.haskell.packages.ghc7103;
  filepath        = true;
}).HS2AST
