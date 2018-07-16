{ nixpkgs ? import <nixpkgs> { config = {}; overlays = []; } }:
import (nixpkgs.fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "03a263f";
  sha256 = "0mw6kf902fkhp7rpx8rfqjr6b7nzky5wyayabmqyr3gj2lngfxn1";
})
