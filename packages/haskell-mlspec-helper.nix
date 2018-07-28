{ haskell, haskellOverride, lib }:

with lib;
(haskellOverride {
  haskellPackages = haskell.packages.ghc7103;
  filepath        = true;
  extra           = [
    (self: super: mapAttrs (n: v: self.callHackage n v {}) {
      # QuickCheck 2.10+ breaks quickspec 1.x
      QuickCheck = "2.9.2";

      # Force version 1 of quickspec, since nixpkgs may be using 2.x
      quickspec = "0.9.6";
    })
  ];
}).mlspec-helper
