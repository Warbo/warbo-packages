{ nixpkgs ? import <nixpkgs> { config = {}; overlays = []; } }:
nixpkgs.fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "35797e2";
  sha256 = "0mj1q72sjbdalcvaqk3pk1ik9k1bgqmd5igv20ks2miwg5hr2bic";
}
