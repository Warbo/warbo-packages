self: super: import ./packages {
  inherit self super;
  inherit (self) newScope;
  inherit (super) lib;
}
