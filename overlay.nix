self: super: import ./packages {
  inherit super;
  inherit (self) newScope;
  inherit (super) haskell haskellPackages lib;
}
