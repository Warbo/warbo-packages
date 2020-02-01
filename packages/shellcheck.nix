# Linter for shell scripts. There is a package with this name in Nixpkgs already
# but it comes from the haskellPackages set, which is less reliable than using
# haskell-nix. I added this override to avoid broken hspec tests, but it makes
# sense to keep it even if haskellPackages.hspec gets fixed.
# TODO: Check for latest version on hackage
{ haskell-nix }:

with rec {
  pkgs = haskell-nix {};

  inherit (pkgs.haskell-nix.hackage-package {
    name        = "ShellCheck";
    version     = "0.7.0";
    ghc         = pkgs.buildPackages.pkgs.haskell-nix.compiler.ghc865;
    index-state = "2020-01-11T00:00:00Z";
  }) components;
};
{
  inherit (components) tests;
  pkg = components.exes.shellcheck;
}
