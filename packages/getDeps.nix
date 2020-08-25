{ gitSource, haskell-nix }:

with rec {
  pkgs = haskell-nix {};

  inherit ((pkgs.haskell-nix.cabalProject {
    src         = gitSource { name = "get-deps"; };
    ghc         = pkgs.buildPackages.pkgs.haskell-nix.compiler.ghc865;
    index-state = "2020-01-11T00:00:00Z";

    # Update these two when the derivation changes
    plan-sha256  = "09d9lja0lzkgscwqm849ixsq4n35lnpa5f6m1krkrqz2r85lgk5s";
    materialized = ../caches/GetDeps-plan-to-nix-pkgs;
  }).GetDeps) components;
};
{
  inherit (components) tests;
  pkg = components.exes.GetDeps;
}
