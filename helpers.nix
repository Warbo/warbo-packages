{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "9e032bf";
    sha256 = "0p0vz1rnx955d03c3y2yydarjd8m96grn4bpdx7rlahqhcnjdk2v";
  };
}
