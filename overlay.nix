self: super:

with builtins;
with super.lib;
with rec {
  # We make heavy use of things from nix-helpers. If it doesn't exist in self
  # then we fall back to this version
  helpers = import (import ./helpers.nix {
                     inherit (super) fetchgit;
                   }).nix-helpers;

  nixFilesIn = self.nixFilesIn or helpers.nixFilesIn;

  util = mapAttrs (_: call) (nixFilesIn ./util);

  # A map from 'base name' (e.g. "foo") to full path (e.g. ./packages/foo.nix)
  pkgFiles = nixFilesIn ./packages;

  # We can't use 'self' when calculating what names we'll provide, since looking
  # up anything in 'self' would cause an infinite recursion if we don't know
  # what our own overrides are called yet. In particular we can't use
  # 'self.nixFilesIn', and hence 'attrNames pkgFiles', so we use 'readDir'.
  fileNames = map (removeSuffix ".nix")
                  (filter (hasSuffix ".nix")
                          (attrNames (readDir ./packages)));

  # Like callPackage, but allows args to come from extraArgs
  call = x: self.newScope extraArgs x {};

  # Allow args to be drawn from helpers, as a fallback if the nix-helpers
  # overlay isn't being used
  extraArgs = (if self ? nix-helpers then {} else helpers) // util // {
    # Useful for overriding things
    inherit extraArgs self super;

    # Many of our definitions use git repos from this URL. As a convenience,
    # we provide a layer of indirection: definitions look for a 'repoSource'
    # parameter, falling back to this if not found. Hence we can use a
    # faster mirror (e.g. local clones) by defining a 'repoSource' parameter
    # in our config, if we want.
    defaultRepo = http://chriswarbo.net/git;
  };

  mkPkg = name: previous:
    with { defs = call (getAttr name pkgFiles); };
    {
      # Each file can either define { pkg = ...; tests = ...; } or else
      # we assume the result is the package and there are no tests.
      pkgs  = previous.pkgs  // { "${name}" = defs.pkg or defs; };
      tests = previous.tests // (if defs ? tests
                                    then { "${name}" = defs.tests; }
                                    else {});
    };

  # Override haskellPackages and haskell.packages.* in an extensible way, so
  # that other overlays can do the same.
  haskellOverride = hsPkgs: util.haskellOverride { haskellPackages = hsPkgs; };

  haskellPackages = haskellOverride super.haskellPackages;
  haskell         = super.haskell // {
    packages = mapAttrs (_: haskellOverride) super.haskell.packages;
  };
};
with fold mkPkg { pkgs = {}; tests = {}; } fileNames;
with rec {
  warbo-packages = pkgs // {
    inherit haskell haskellPackages warbo-packages;
    warbo-packages-tests = tests;
  };
};
warbo-packages
