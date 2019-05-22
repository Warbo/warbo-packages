{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "b11e59b";
    sha256 = "0zjczsd40b73rd5mwmp14cm25sy3wrr34zd42s6g0rqdbbdi51wz";
  };
}
