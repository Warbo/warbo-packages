{ defaultRepo, forceLatest ? false, hasBinary, latestGit,
  repoSource ? defaultRepo }:

with {
  src = latestGit {
    url    = "${repoSource}/asv-nix.git";
    stable = {
      rev        = "249f560";
      sha256     = "0b9l2kmbxwaqxh9nfsz48kjdqfgmbk5z232zc683zazjdlzypbw1";
      unsafeSkip = forceLatest;
    };
  };
};
rec {
  pkg   = import "${src}" { inherit path; };
  tests = hasBinary pkg "asv";
}
