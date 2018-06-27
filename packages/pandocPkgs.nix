# Fixed versions of pandoc, panpipe, panhandle, pandoc-citeproc and dependencies
{ defaultRepo, forceLatest ? false, hasBinary, haskellPkgsDeps, latestGit,
  nixpkgs1709, repoSource ? defaultRepo, runCommand, withDeps }:

# Runs Cabal's dependency solver to find non-conflicting versions of all the
# required packages, runs cabal2nix on all of them and passes them as overrides
# to the given hsPkgs set.
with haskellPkgsDeps {
  deps = [
    "base >= 4.8"
    "pandoc-citeproc == 0.10.4"
    "panpipe == 0.2.0.0"
    "panhandle == 0.3.0.0"
    #"aeson == 0.11.3.0"
    "attoparsec == 0.13.0.2"
    "tasty == 0.11.2.1"
    "lazysmallcheck2012"
    "pandoc"
  ];

  extra-sources = [
    (latestGit {
      url    = "${repoSource}/lazy-smallcheck-2012.git";
      stable = {
        rev        = "dbd6fba";
        sha256     = "1i3by7mp7wqy9anzphpxfw30rmbsk73sb2vg02nf1mfpjd303jj7";
        unsafeSkip = forceLatest;
      };
    })
    (latestGit {
      url    = "${repoSource}/panhandle.git";
      stable = {
        rev        = "7e44d75";
        sha256     = "1cgk5wslbr507fmh1fyggvk15lipa8x815392j9qf4f922iifdzn";
        unsafeSkip = forceLatest;
      };
    })
  ];

  # This is an end-user package, not a library, so we don't care about plumbing
  # it up for all of the various nixpkgs and Haskell versions. Just pick one and
  # stick with it, rather than building things over and over.
  hsPkgs = nixpkgs1709.haskell.packages.ghc7103;

  useOldZlib = true;
};
rec {
  # Add the "gcRoots" as dependencies; these are derivations we imported in
  # order to generate the required Haskell packages, but which aren't actually
  # included in the dependencies of anything. Notably this includes hackageDb.
  # By adding these as dependencies here, we ensure the GC sees them as live.
  pkg = withDeps gcRoots (runCommand "pandocPkgs"
    {
      wanted = hsPkgs.ghcWithPackages (h: [
        h.pandoc
        h.panpipe
        h.pandoc-citeproc
        h.panhandle
      ]);
    }
    ''
      # Pluck out the binaries we want, ignore those we don't (e.g. ghc)
      mkdir -p "$out/bin"
      for P in pandoc pandoc-citeproc panhandle panpipe
      do
        ln -s "$wanted/bin/$P" "$out/bin/$P"
      done
    '');
  tests = {};#hasBinary pkg "pandoc";
}
