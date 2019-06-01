{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "92a6b8c";
    sha256 = "0vhbm4dag222wwvsgvl6lm67sn2yan80c1f1j90228wd1j0izc76";
  };
}
