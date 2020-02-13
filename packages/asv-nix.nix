{ defaultRepo, fetchgit, hasBinary, path, repoSource ? defaultRepo }:

with {
  src = fetchgit {
    url    = "${repoSource}/asv-nix.git";
    rev    = "0d7762b";
    sha256 = "17kdkzxc9k961shb685dw003rsmxaxyk03byi3sw6j3x4l18qidx";
  };
};
rec {
  pkg   = import "${src}" { inherit path; };
  tests = hasBinary pkg "asv";
}
