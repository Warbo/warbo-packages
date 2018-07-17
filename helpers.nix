{ nixpkgs ? import <nixpkgs> { config = {}; overlays = []; } }:
nixpkgs.fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "6227a40";
  sha256 = "077kcal167ixwjj41sqrndd5pwvyavs20h826qx3ijl2i02wmwxs";
}
