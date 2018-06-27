self: super:

with builtins;
with super.lib;
with rec {
  # We make heavy use of things from nix-helpers. If it doesn't exist in self
  # then we fall back to this version
  helpers = import (super.fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "0fe63a2";
    sha256 = "07lhjh8h7wmin2bsc8583whsz3kppavrflxfjal6d6wansi8x42b";
  });

  # A map from 'base name' (e.g. "foo") to full path (e.g. ./packages/foo.nix)
  pkgFiles  = (self.nixFilesIn or helpers.nixFilesIn) ./packages;

  # We can't use 'self' when calculating what names we'll provide, since looking
  # up anything in 'self' would cause an infinite recursion if we don't know
  # what our own overrides are called yet. In particular we can't use
  # 'self.nixFilesIn', and hence 'attrNames pkgFiles', so we use 'readDir'.
  fileNames = map (removeSuffix ".nix") (attrNames (readDir ./packages));
};
with fold (name: previous:
            with rec {
              # Allow args to be drawn from helpers, as a fallback if the
              # nix-helpers overlay isn't being used
              extraArgs = (if self ? nix-helpers then {} else helpers) // {
                # Many of our definitions use git repos from this URL. As a
                # convenience, we provide a layer of indirection: definitions
                # look for a 'repoSource' parameter, falling back to this if not
                # found. Hence we can use a faster mirror (e.g. local clones) by
                # defining it as a 'repoSource' parameter, if we want to.
                defaultRepo = http://chriswarbo.net/git;
              };

              # Like callPackage, but allows args to come from extraArgs
              defs = self.newScope extraArgs (getAttr name pkgFiles) {};
            };
            {
              # Each file can either define { pkg = ...; tests = ...; } or else
              # we assume the result is the package and there are no tests.
              pkgs  = previous.pkgs  // { "${name}" = defs.pkg or defs; };
              tests = previous.tests // (if defs ? tests
                                            then { "${name}" = defs.tests; }
                                            else {});
            })
          { pkgs = {}; tests = {}; }
          fileNames;
with rec {
  warbo-packages = pkgs // {
    inherit warbo-packages;
    warbo-packages-tests = tests;
  };
};
warbo-packages
