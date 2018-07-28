{ haskell, haskellOverride, lib }:

with lib;
(haskellOverride {
  haskellPackages = haskell.packages.ghc7103;
  filepath        = true;
  extra           = [
    (self: super: mapAttrs (n: v: self.callHackage n v {}) {
      # Default is missing semigroups dependency
      haskell-src-exts = "1.16.0.1";

      # Force version 1 of quickspec, since nixpkgs may be using 2.x
      quickspec = "0.9.6";
    })
  ];
}).mlspec
