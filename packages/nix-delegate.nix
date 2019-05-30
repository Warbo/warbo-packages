{ hasBinary, latestGit, lib, nixpkgs1803 }:

with rec {
  get = unsafeSkip: latestGit {
    url    = https://github.com/awakesecurity/nix-delegate.git;
    stable = {
      inherit unsafeSkip;
      rev    = "aeb6c4a";
      sha256 = "0qb83jkb495vgh912sdiqcph7zrppm4rch9j25m5988d9y1ykgja";
    };
  };

  f = { forceLatest, haskellPackages }:
    haskellPackages.callPackage (get forceLatest) {};
};
rec {
  pkg = lib.makeOverridable f {
    inherit (nixpkgs1803) haskellPackages;
    forceLatest = false;
  };
  tests = hasBinary pkg "nix-delegate";
}
