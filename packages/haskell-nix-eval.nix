{ haskellOverride, nixEvalOverrides, nixpkgs1803 }:

(haskellOverride {
  haskellPackages = nixpkgs1803.haskell.packages.ghc7103;
  extra           = nixEvalOverrides;
}).nix-eval
