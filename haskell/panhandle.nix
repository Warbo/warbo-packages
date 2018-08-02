self: super: helf: huper:

with builtins;
with {
  # We must use a git checkout due to a bug in panhandle.cabal: the test suite
  # doesn't put its internal modules in 'other-modules', so they don't end up in
  # the sdist tarball. This is fixed in 0.3 but we want 0.2 for dependencies.
  panhandleSrc = trace "FIXME: Backport panhandle 'other-modules' patch to 2.x and push to Hackage" self.latestGit {
    url    = "${self.repoSource or self.defaultRepo}/panhandle.git";
    stable = {
      rev        = "83eb3a7";
      sha256     = "0sc43023ww4kakxyhzb26fv15b633a5n7aiqayrida87686w3icn";
      unsafeSkip = false;
    };
  };
};
helf.callPackage (self.hs2nix helf {
  name = "panhandle";
  src  = panhandleSrc;
}) {}
