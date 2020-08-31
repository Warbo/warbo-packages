self: super: import ./packages {
  inherit super;
  inherit (self) newScope;
  inherit (super) lib;
}
