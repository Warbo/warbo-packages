{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "43decb5";
    sha256 = "0ypi2klnjmq51xhv893q5d6xad1i7hyibmyq79rfxci6ysgsd97x";
  };
}
