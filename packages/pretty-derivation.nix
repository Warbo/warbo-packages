# Pretty-printer for Nix .drv files
{ haskell-nix }:

with rec {
  pkgs = haskell-nix {};

  inherit (pkgs.haskell-nix.hackage-package {
    name        = "nix-derivation";
    version     = "1.0.2";
    ghc         = pkgs.buildPackages.pkgs.haskell-nix.compiler.ghc865;
    index-state = "2020-01-11T00:00:00Z";

    # Update these when changing the derivation
    plan-sha256  = "08lzvl34crpxnrqfk4af7khij1g28g5kdjmm8w7vmyk8wxqwgmqn";
    materialized = ../caches/nix-derivation-plan-to-nix-pkgs;
  }) components;
};
{
  inherit (components) tests;
  pkg = components.exes.pretty-derivation;
}
