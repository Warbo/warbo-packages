{ haskell, lib }:

with lib;
[
  (self: super: mapAttrs (n: v: self.callHackage n v {}) {
    haskell-src-exts = "1.16.0.1";

    # QuickCheck 2.10+ breaks quickspec 1.x
    QuickCheck = "2.9.2";

    # Nixpkgs version doesn't support QuickCheck < 2.10
    quickcheck-instances = "0.3.14";

    # Force version 1 of quickspec, since nixpkgs may be using 2.x
    quickspec = "0.9.6";

    # Needed for text-short
    tasty-quickcheck = "0.8.4";

    # Nixpkgs version has incorrect dependencies, presumably due to being built
    # against GHC 8 rather than 7
    text-short = "0.1.1";

    # Nixpkgs version is missing semigroups dependency
    transformers-compat = "0.5.1.4";
  })
  (self: super: {
    aeson    = haskell.lib.dontCheck super.aeson;

    hindent  = super.hindent.override {
      inherit (self) haskell-src-exts;
    };

    nix-eval = super.nix-eval.override {
      inherit (self) hindent;
    };
  })
]
