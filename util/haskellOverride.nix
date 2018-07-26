# Defines an override function which can be used with haskellPackages.override
# to append the contents of the ../haskell directory.

# Naming convention:
#  - self : nixpkgs with our overrides applied (watch out for infinite loops!)
#  - super: nixpkgs without our overrides applied (useful for breaking loops)
#  - helf : haskell set with our overrides applied (watch out for loops!)
#  - huper: haskell set without our overrides applied (for breaking loops)
{ extraArgs, lib, nixFilesIn }:

with lib;
helf: huper:
  mapAttrs (_: f: import f (extraArgs.self // extraArgs)
                           extraArgs.super
                           helf
                           huper)
           (nixFilesIn ../haskell)
