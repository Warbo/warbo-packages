{ haskell, haskellOverride, lib }:

with lib;
(haskellOverride {
  haskellPackages = haskell.packages.ghc7103;
  extra           = [
    (self: super: mapAttrs (n: v: self.callHackage n v {}) {
      haskell-src-exts = "1.16.0.1";

      # Nixpkgs version is missing semigroups dependency
      transformers-compat = "0.5.1.4";
    })
  ];
}).runtime-arbitrary-tests
