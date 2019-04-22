{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "ea0ea7c";
    sha256 = "1rchcc10s3spxbbwi9sz4v3cjcgcakq33hrqk9rkznrv8q2v831w";
  };
}
