{ defaultRepo, latestGit, nixpkgs1609, panPkgs, repo1709,
  repoSource ? defaultRepo,runCommand, stdenv, super }:

with builtins;
with rec {
  oldHs  = nixpkgs1609.haskell.packages.ghc7103.override {
    overrides = panPkgs;
  };

  rawPath = "${repo1709}/pkgs/development/haskell-modules/hackage-packages.nix";

  replacements = [
    # nixpkgs1609 will die on a broken pkg before we get a chance to override it
    { old =             "broken = true;"; new = ""; }

    # Remove default dummy lazysmallcheck2012 (cause by not being on Hackage)
    { old = "lazysmallcheck2012 = null;"; new = ""; }

    # Lets us override the panhandle source to fix bugs
    { old = "sha256 = \"1xkpivyw3r83hrksbq4vyf1ahqp86ck7m2ijgynbb962ifvwqrg0\";";
      new = "src = self.panhandleSrc;"; }
  ];

  path = runCommand "unbroken-hackage.nix" { inherit rawPath; } ''
    sed ${concatStringsSep " "
            (map (x: "-e 's/${x.old}/${x.new}/g'")
                 replacements)} < "$rawPath" > "$out"
  '';

  # We must use a git checkout due to a bug in panhandle.cabal: the test suite
  # doesn't put its internal modules in 'other-modules', so they don't end up in
  # the sdist tarball. This is fixed in 0.3 but we want 0.2 for dependencies.
  panhandleSrc = trace "FIXME: Backport panhandle 'other-modules' patch to 2.x and push to Hackage" latestGit {
    url    = "${repoSource}/panhandle.git";
    stable = {
      rev        = "83eb3a7";
      sha256     = "0sc43023ww4kakxyhzb26fv15b633a5n7aiqayrida87686w3icn";
      unsafeSkip = false;
    };
  };

  hsPkgs = import path {
    inherit stdenv;
    inherit (oldHs) callPackage;
    pkgs = super;
  } (hsPkgs // { inherit panhandleSrc; });
};
hsPkgs.panhandle
