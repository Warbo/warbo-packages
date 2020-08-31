{ haskell-nix }:

with {
  pkgs = haskell-nix {};
};
(pkgs.haskell-nix.hackage-package {
  name        = "nix-diff";
  version     = "1.0.7";
  ghc         = pkgs.buildPackages.pkgs.haskell-nix.compiler.ghc865;
  index-state = "2020-01-11T00:00:00Z";

  # Update these when the changing this derivation
  plan-sha256  = "1j1wb27qbwjhx52n7brnyjsc66nhvfwblfyvvglah1rqwh580pvc";
  materialized = ../caches/nix-diff-plan-to-nix-pkgs;
}).components
