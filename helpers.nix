{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "61bfdc9";
    sha256 = "05j91afl8i0favvvkgas975z0f45h9jr27ww5by56xf744y5d6pw";
  };
}
