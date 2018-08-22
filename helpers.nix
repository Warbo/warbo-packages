{ nixpkgs ? import <nixpkgs> { config = {}; overlays = []; } }:
nixpkgs.fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "05182d0";
  sha256 = "1h8jrjrbbab0fymssdwgzl171x6lq817sjd8hzhia7kn5mgm2fib";
}
