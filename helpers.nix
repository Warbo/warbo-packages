{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "dcd2d23";
    sha256 = "1xq80iq8994za9hhk246z26g8zjgpmd2845d084qqixn0xjgqcjf";
  };
}
