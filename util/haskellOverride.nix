# Defines an function for overriding haskellPackages, appending the contents of
# the ../haskell directory (among other things)

# Naming convention:
#  - self : nixpkgs with our overrides applied (watch out for infinite loops!)
#  - super: nixpkgs without our overrides applied (useful for breaking loops)
#  - helf : haskell set with our overrides applied (watch out for loops!)
#  - huper: haskell set without our overrides applied (for breaking loops)
{ extraArgs, filepathFix, lib, nixFilesIn, nixpkgs1803, panPkgs }:

with lib;
with {
  composeAll = fold nixpkgs1803.lib.composeExtensions (_: _: {});

  dummy = _: _: {};

  generalOverrides = helf: huper:
    mapAttrs (_: f: import f (extraArgs.self // extraArgs)
                             extraArgs.super
                             helf
                             huper)
             (nixFilesIn ../haskell);

  panPkgsOverrides = panPkgs;

  semigroupsOverrides = ghc7SemigroupsFix;
};
{
  haskellPackages,
  existing ? true,
  general  ? true,
  panPkgs  ? false,
  filepath ? false,
  extra    ? []
}:
  haskellPackages.override (old: {
    overrides = composeAll (concatLists [
      (if existing then [ (old.overrides or dummy) ] else [])
      (if general  then [ generalOverrides ] else [])
      (if panPkgs  then [ panPkgsOverrides ] else [])
      (if filepath then [ filepathFix      ] else [])
      extra
    ]);
  })
