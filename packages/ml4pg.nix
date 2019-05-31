{ callPackage, defaultRepo, forceLatest ? false, latestGit, nothing,
  repoSource ? defaultRepo }:

{
  pkg = builtins.trace "ML4PG disabled" nothing/*
  callPackage
    (latestGit {
      url    = "${repoSource}/ml4pg.git";
      ref    = "master";
      stable = {
        rev        = "d9392e0";
        sha256     = "0fc748a1nilz8wwqmkqslin26xs6l5fc547gnsq124ik3sdivhhc";
        unsafeSkip = forceLatest;
      };
    })
    {}
  */;
  tests = {};
}
