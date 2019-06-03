{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "25ddfc2";
    sha256 = "0y6mj3zbiyx1z351sgpid17yw2b1672am1l2slhvd1z0aai86z6s";
  };
}
