{ nixpkgs ? import <nixpkgs> { config = {}; overlays = []; } }:
nixpkgs.fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "05dc3d5";
  sha256 = "1acq5fwlpz3m23wqcvp25slbgl3kxhwh3l95y1x4c3zbwbd0m3rh";
}
