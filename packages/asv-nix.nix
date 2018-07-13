{ defaultRepo, forceLatest ? false, hasBinary, latestGit, newScope,
  nix-helpers, repoSource ? defaultRepo  }:

with {
  src = latestGit {
    url    = "${repoSource}/asv-nix.git";
    stable = {
      rev        = "433f0fa";
      sha256     = "1zb3l1h2zdixs4x6cihvjimw3gyfns5n78acm6ylac3hdn55lpq2";
      unsafeSkip = forceLatest;
    };
  };
};
rec {
  pkg   = newScope nix-helpers "${src}/derivation.nix" {};
  tests = hasBinary pkg "asv";
}
