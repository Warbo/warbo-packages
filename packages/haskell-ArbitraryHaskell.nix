{ haskell, lib, runCabal2nix }:

with {
  hsPkgs = haskell.packages.ghc7103.override (old: {
    overrides = lib.composeExtensions
      (old.overrides or (_: _: {}))
      (self: super: {
        haskell-src-exts = self.callPackage (runCabal2nix {
          url = "cabal://haskell-src-exts-1.17.1";
        }) {};
        semigroups = self.callPackage (runCabal2nix {
          url = "cabal://semigroups-0.14";
        }) {};
      });
  });
};

hsPkgs.ArbitraryHaskell
