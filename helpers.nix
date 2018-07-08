{ nixpkgs ? import <nixpkgs> { config = {}; overlays = []; } }:
import (nixpkgs.fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "bb75beb";
  sha256 = "0cyp3drylrp0dvh4sll5lvi0n511grxfpmka2d5pdy4jxl0803p5";
})
