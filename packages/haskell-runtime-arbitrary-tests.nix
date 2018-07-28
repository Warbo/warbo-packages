{ haskell, haskellOverride, lib }:

with lib;
(haskellOverride {
  haskellPackages = haskell.packages.ghc7103;
  extra           = [
    (self: super: mapAttrs (n: v: self.callHackage n v {}) {
      haskell-src-exts = "1.16.0.1";
    })
  ];
}).runtime-arbitrary-tests
