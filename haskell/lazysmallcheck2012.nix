self: super: helf: huper:

with {
  src = self.latestGit {
    url    = "${self.repoSource or self.defaultRepo}/lazy-smallcheck-2012.git";
    stable = {
      rev        = "dbd6fba";
      sha256     = "1i3by7mp7wqy9anzphpxfw30rmbsk73sb2vg02nf1mfpjd303jj7";
      unsafeSkip = false;
    };
  };
};
helf.callPackage (self.haskellSrc2nix {
  inherit src;
  name = "lazysmallcheck2012";
}) {
  mkDerivation = args: helf.mkDerivation
    (removeAttrs args [ "benchmarkHaskellDepends" ]);
}
