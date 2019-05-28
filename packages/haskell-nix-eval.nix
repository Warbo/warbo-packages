{ haskellOverride, nixEvalOverrides, nixpkgs1809 }:

(haskellOverride {
  haskellPackages = nixpkgs1809.haskell.packages.ghc7103;
  extra           = nixEvalOverrides;
}).nix-eval
