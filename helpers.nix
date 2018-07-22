{ nixpkgs ? import <nixpkgs> { config = {}; overlays = []; } }:
nixpkgs.fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "be60e51";
  sha256 = "10jxrcfizgmrxnzsj9vfbak36bnfyf1jz2rx7mb51djg97f9qvqf";
}
