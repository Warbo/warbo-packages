self: super: helf: huper:

with {
  src = self.latestGit {
    url    = "${self.repoSource or self.defaultRepo}/lazy-smallcheck-2012.git";
    stable = {
      rev        = "01b536e";
      sha256     = "05d83z6dcb8651rsnkj84kk95paz64vgy616fr3qi8b5nfmccy4l";
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
