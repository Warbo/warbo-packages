{ nixpkgs ? import <nixpkgs> { config = {}; overlays = []; } }:
nixpkgs.fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "148bd5e";
  sha256 = "0wywgdmv4gllarayhwf9p41pzrkvgs32shqrycv2yjkwz321w8wl";
}
