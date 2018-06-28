{ nixpkgs1609, panPkgs, repo1803, stdenv, super }:

with rec {
  oldHs  = nixpkgs1609.haskell.packages.ghc7103.override {
    overrides = panPkgs;
  };

  path   = "${repo1803}/pkgs/development/haskell-modules/hackage-packages.nix";

  hsPkgs = import path {
    inherit stdenv;
    inherit (oldHs) callPackage;
    pkgs = super;
  } hsPkgs;
};
hsPkgs.panpipe
