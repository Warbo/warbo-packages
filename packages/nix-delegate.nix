{ forceLatest ? false, hasBinary, haskellPackages, latestGit }:

with {
  src = latestGit {
    url    = https://github.com/awakesecurity/nix-delegate.git;
    stable = {
      rev        = "aeb6c4a";
      sha256     = "0qb83jkb495vgh912sdiqcph7zrppm4rch9j25m5988d9y1ykgja";
      unsafeSkip = forceLatest;
    };
  };
};
rec {
  pkg   = haskellPackages.callPackage src {};
  tests = hasBinary pkg "nix-delegate";
}
