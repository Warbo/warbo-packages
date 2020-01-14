self: super: helf: huper:

with {
  src = self.latestGit {
    url    = "${self.repoSource or self.defaultRepo}/lazy-smallcheck-2012.git";
    stable = {
      rev        = "f138ac3";
      sha256     = "1m99nha131hqzi6yx6189rvcska4wvz768m1n5kq4mrw9sk50nxc";
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
