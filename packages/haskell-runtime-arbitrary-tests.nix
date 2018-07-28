{ haskell, haskellOverride, lib }:

with lib;
with {
  haskellPackages = haskellOverride {
    haskellPackages = haskell.packages.ghc7103;
    extra           = [
      (self: super: mapAttrs (n: v: self.callHackage n v {}) {
        haskell-src-exts = "1.16.0.1";

        # Nixpkgs version is missing semigroups dependency
        transformers-compat = "0.5.1.4";
      })
      (self: super: {
        hindent  = super.hindent.override {
          inherit (self) haskell-src-exts;
        };

        nix-eval = super.nix-eval.override {
          inherit (self) hindent;
        };
      })
    ];
  };
};
with builtins; trace (toJSON haskellPackages.runtime-arbitrary-tests.buildInputs)
haskellPackages.runtime-arbitrary-tests
