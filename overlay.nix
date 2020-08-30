self: super:

with rec {
  inherit (builtins) attrNames getAttr readDir;
  inherit (super.lib) filter fold hasSuffix mapAttrs removeSuffix;
  inherit (helpers) nixFilesIn;

  helpers = import (self.warbo-packages-sources.nix-helpers);

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
  extraArgs = helpers // util // {
    # Useful for overriding things
    inherit extraArgs self super;
  };

  mkPkg = name: previous:
    with { defs = call (getAttr name pkgFiles); };
    {
      # Each file can either define { pkg = ...; tests = ...; } or else
      # we assume the result is the package and there are no tests.
      pkgs  = previous.pkgs  // { "${name}" = defs.pkg;   };
      tests = previous.tests // { "${name}" = defs.tests; };
    };

  # Override haskellPackages and haskell.packages.* in an extensible way, so
  # that other overlays can do the same.
  haskellOverride = hsPkgs: util.haskellOverride { haskellPackages = hsPkgs; };

  haskellPackages = haskellOverride super.haskellPackages;
  haskell         = super.haskell // {
    packages = mapAttrs (_: haskellOverride) super.haskell.packages;
  };
};
with fold mkPkg { pkgs = {}; tests = call ./tests.nix; } fileNames;
with rec {
  warbo-packages = pkgs // {
    inherit haskell haskellPackages warbo-packages;
    warbo-packages-tests = tests;
  };
};
warbo-packages
