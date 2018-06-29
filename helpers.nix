{ nixpkgs ? import <nixpkgs> { config = {}; overlays = []; } }:
import (nixpkgs.fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "054bd5c";
  sha256 = "00y71b215m8z9c1xxdbhc2l8vv63jph2cpwq8qii803nsx005pjz";
})
