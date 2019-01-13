{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "5cecd3f";
  sha256 = "0g4qjciim81wi2hqydmlkxcb1923gaxdln5qx5icyy3639ap6xq3";
}
