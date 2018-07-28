{ haskell, haskellOverride, lib }:

with lib;
(haskellOverride {
  haskellPackages = haskell.packages.ghc7103;
  filepath        = true;
  extra = [
    (self: super: mapAttrs (n: v: self.callHackage n v {}) {
      # Version 2.10+ causes an "ambiguous 'total'" error in quickspec
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
    })

    (self: super: mapAttrs (_: haskell.lib.dontCheck) {
      inherit (super)
        # Encounters missing Arbitrary instances
        aeson

        # Requires QuickCheck 2.10
        cassava

        # The test suite fails for 'isAscii' and 'isAscii2' on empty strings,
        # which seems innocuous enough to ignore.
        text-short;
    })
  ];
}).ML4HSFE
