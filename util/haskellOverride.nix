# Defines an function for overriding haskellPackages, appending the contents of
# the ../haskell directory (among other things)

# Naming convention:
#  - self : nixpkgs with our overrides applied (watch out for infinite loops!)
#  - super: nixpkgs without our overrides applied (useful for breaking loops)
#  - helf : haskell set with our overrides applied (watch out for loops!)
#  - huper: haskell set without our overrides applied (for breaking loops)
{ extraArgs, filepathFix, lib, nixFilesIn, nixpkgs1803, stdenv }:

with rec {
  inherit (builtins) trace;
  inherit (lib) concatLists fold hasSuffix mapAttrs;

  composeAll = fold nixpkgs1803.lib.composeExtensions (_: _: {});

  dummy = _: _: {};

  generalOverrides = helf: huper:
    mapAttrs (_: f: import f (extraArgs.self // extraArgs)
                             extraArgs.super
                             helf
                             huper)
             (nixFilesIn ../haskell);

  sybOverrides = self: super: { syb = self.callHackage "syb" "0.6" {}; };

  go = {
    haskellPackages,
    existing ? true,
    general  ? true,
    filepath ? false,
    syb      ? false,
    extra    ? []
  }:
    haskellPackages.override (old: {
      overrides = composeAll (concatLists [
        (if existing then [ (old.overrides or dummy) ] else [])
        (if general  then [ generalOverrides         ] else [])
        (if filepath then [ filepathFix              ] else [])
        (if syb      then [ sybOverrides             ] else [])
        extra
      ]);
    });
};
if stdenv.isDarwin
   then trace "Skipping haskellOverride on macOS" (x: x)
   else go
