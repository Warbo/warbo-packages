{ defaultRepo, forceLatest ? false, hasBinary, latestGit, newScope,
  nix-helpers, repoSource ? defaultRepo  }:

with {
  src = latestGit {
    url    = "${repoSource}/asv-nix.git";
    stable = {
      rev        = "d3789cc";
      sha256     = "1b9l2kmbxwaqxh9nfsz48kjdqfgmbk5z232zc683zazjdlzypbw1";
      unsafeSkip = forceLatest;
    };
  };
};
rec {
  pkg   = newScope nix-helpers "${src}/derivation.nix" {};
  tests = hasBinary pkg "asv";
}
