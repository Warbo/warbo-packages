# The system-filepath package requires semigroups for GHC 7.x, but the nixpkgs
# package doesn't have this dependency since it was generated with GHC 8.x
{ haskell }:

helf: huper: {
  system-filepath = haskell.lib.addBuildDepend huper.system-filepath
                                               helf.semigroups;
}
