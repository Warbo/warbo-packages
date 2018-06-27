{ defaultRepo, forceLatest ? false, git2html-real, hasBinary, latestGit,
  repoSource ? defaultRepo, stdenv, withDeps }:

with rec {
  pkg = stdenv.lib.overrideDerivation git2html-real (old: {
    src = latestGit {
      url    = "${repoSource}/git2html.git";
      stable = {
        rev        = "121d5bc";
        sha256     = "0rbfpjjdfqhys85qga4js4ha5cgjdhj5dwqgkvvcki32k3sgaplf";
        unsafeSkip = forceLatest;
      };
    };
  });

  tested = withDeps [ (hasBinary pkg "git2html") ] pkg;
};
{
  pkg   = tested;
  tests = tested;
}
