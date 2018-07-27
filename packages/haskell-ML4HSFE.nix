{ haskell, haskellOverride }:

(haskellOverride {
  haskellPackages = haskell.packages.ghc7103;
  filepath        = true;
  extra           = helf: huper: {
    # Force version 1 of quickspec
    quickspec = helf.callHackage "quickspec" "0.9.6" {};
  };
}).ML4HSFE
