# Linter for shell scripts. There is a package with this name in Nixpkgs already
# but it comes from the haskellPackages set, which is less reliable than using
# haskell-nix. I added this override to avoid broken hspec tests, but it makes
# sense to keep it even if haskellPackages.hspec gets fixed.
# TODO: Check for latest version on hackage
{ haskell-nix }:

with {
  pkgs = haskell-nix {};
};
(pkgs.haskell-nix.hackage-package {
  name        = "ShellCheck";
  version     = "0.7.0";
  ghc         = pkgs.buildPackages.pkgs.haskell-nix.compiler.ghc865;
  index-state = "2020-01-11T00:00:00Z";

  # Update these two when the derivation changes
  plan-sha256  = "183rh6lljf42qg42xxccvbp3kmhmpl4qzlzmx2h3p755f06lxljs";
  materialized = ../caches/ShellCheck-plan-to-nix-pkgs;
}).components
