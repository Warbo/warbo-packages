{ haskell, haskellOverride }:

(haskellOverride {
  haskellPackages = haskell.packages.ghc7103;
  filepath        = true;
  extra           = helf: huper: {
    # Version 2.10+ causes an "ambiguous 'total'" error in quickspec
    QuickCheck = helf.callHackage "QuickCheck" "2.9.2" {};

    # Force version 1 of quickspec, since nixpkgs may be using 2.x
    quickspec = helf.callHackage "quickspec" "0.9.6" {};
  };
}).ML4HSFE
