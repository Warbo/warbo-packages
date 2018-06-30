{ nixpkgs ? import <nixpkgs> { config = {}; overlays = []; } }:
import (nixpkgs.fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "3354810";
  sha256 = "0xzv515v68hspps6q8hbf1y7lsamp2bdkkp7rk94f6722mmjihwa";
})
