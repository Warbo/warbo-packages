{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "4e1b7b2";
    sha256 = "1f3vwsnk0nrwsjll7823fyvbqh9w4ghljkzvh0q4fn2wncb1mr2w";
  };
}
