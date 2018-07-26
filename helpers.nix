{ nixpkgs ? import <nixpkgs> { config = {}; overlays = []; } }:
nixpkgs.fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "510099c";
  sha256 = "04d6s7a8m1rjkj1kjz4myx3x80dh5jrrjkwqvsydmq41vafg7lhx";
}
