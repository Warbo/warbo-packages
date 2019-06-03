{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "6d1ee67";
    sha256 = "0y5260r2rrxr2b10501i5bkwx4zpf4p6xsz1dhpk5l8spn89c84w";
  };
}
