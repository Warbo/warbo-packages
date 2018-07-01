{ defaultRepo, forceLatest ? false, git2html-real, hasBinary, latestGit,
  repoSource ? defaultRepo, stdenv }:

rec {
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

  tests = hasBinary pkg "git2html";
}
