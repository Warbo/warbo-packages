{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "67a95ee";
    sha256 = "1qycic4xwxscfi148z7cjaciabkn49lr54qmfcrf8by9w856a61a";
  };
}
