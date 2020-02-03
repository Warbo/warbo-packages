# Pretty-printer for Nix .drv files
{ haskell-nix }:

with rec {
  pkgs = haskell-nix {};

  inherit (pkgs.haskell-nix.hackage-package {
    name        = "nix-derivation";
    version     = "1.0.2";
    ghc         = pkgs.buildPackages.pkgs.haskell-nix.compiler.ghc865;
    index-state = "2020-01-11T00:00:00Z";
  }) components;
};
{
  inherit (components) tests;
  pkg = components.exes.pretty-derivation;
}
