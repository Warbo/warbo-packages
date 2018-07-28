{ die, haskell, haskellOverride, lib }:

with lib;
with {
  haskellPackages = haskellOverride {
  haskellPackages = haskell.packages.ghc7103;
    extra           = [
      (self: super: mapAttrs (n: v: self.callHackage n v {}) {
        haskell-src-exts = "1.16.0.1";
        hindent          = "5.2.5";
      })
    ];
  };
};
haskellPackages.nix-eval
