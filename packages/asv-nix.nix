{ defaultRepo, forceLatest ? false, hasBinary, latestGit, newScope,
  nix-helpers, repoSource ? defaultRepo  }:

with {
  src = latestGit {
    url    = "${repoSource}/asv-nix.git";
    stable = {
      rev        = "cd2ee1c";
      sha256     = "0lpnwshyz47bmbyh1ribivh8997m582p6izg1la2ca8n6yki4bxc";
      unsafeSkip = forceLatest;
    };
  };
};
rec {
  pkg   = newScope nix-helpers "${src}/derivation.nix" {};
  tests = hasBinary pkg "asv";
}
