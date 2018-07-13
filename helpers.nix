{ nixpkgs ? import <nixpkgs> { config = {}; overlays = []; } }:
import (nixpkgs.fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "96a2fa3";
  sha256 = "0j5xxgjbyjsj9ayj3q7b95s7gzmmahwlj27nvbmdjyrxk3dn7gxz";
})
