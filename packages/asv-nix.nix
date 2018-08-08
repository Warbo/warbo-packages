{ defaultRepo, forceLatest ? false, hasBinary, latestGit, path,
  repoSource ? defaultRepo }:

with {
  src = latestGit {
    url    = "${repoSource}/asv-nix.git";
    stable = {
      rev        = "54d2a89";
      sha256     = "0hh56xk8z1bzv2v1j2vxmmap8bww8wkjkfqx4cf43jgigalw5miz";
      unsafeSkip = forceLatest;
    };
  };
};
rec {
  pkg   = import "${src}" { inherit path; };
  tests = hasBinary pkg "asv";
}
