{ haskell, haskellOverride, lib }:

with lib;
(haskellOverride {
  haskellPackages = haskell.packages.ghc7103;
  extra = [
    (self: super: mapAttrs (n: v: self.callHackage n v {}) {
      # Force version 1 of quickspec, since nixpkgs may be using 2.x
      quickspec = "0.9.6";
    })
  ];
}).mlspec
