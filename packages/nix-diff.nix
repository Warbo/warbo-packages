{ haskell-nix }:

with rec {
  pkgs = haskell-nix {};

  inherit (pkgs.haskell-nix.hackage-package {
    name        = "nix-diff";
    version     = "1.0.7";
    ghc         = pkgs.buildPackages.pkgs.haskell-nix.compiler.ghc865;
    index-state = "2020-01-11T00:00:00Z";
  }) components;
};
{
  inherit (components) tests;
  pkg = components.exes.nix-diff;
}
