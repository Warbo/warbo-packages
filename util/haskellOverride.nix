# Defines an override function which can be used with haskellPackages.override
# to append the contents of the ../haskell directory.

# Naming convention:
#  - self : nixpkgs with our overrides applied (watch out for infinite loops!)
#  - super: nixpkgs without our overrides applied (useful for breaking loops)
#  - helf : haskell set with our overrides applied (watch out for loops!)
#  - huper: haskell set without our overrides applied (for breaking loops)
{ composeAll, extraArgs, filepathFix, lib, nixFilesIn, panPkgs }:

with lib;
with {
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
  filepath ? false
}:
  haskellPackages.override (old: {
    overrides = composeAll (if existing && old ? overrides
                               then old.overrides
                               else (_: _: {}))
                           (concatLists [
                             (if general  then [ generalOverrides ] else [])
                             (if panPkgs  then [ panPkgsOverrides ] else [])
                             (if filepath then [ filepathFix      ] else [])
                           ]);
  })
