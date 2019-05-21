{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "cf888f6";
    sha256 = "04b8gbhzf3sy877n46l84jra4q8mwgzhrbdg4fpxig5bmnmigrd1";
  };
}
