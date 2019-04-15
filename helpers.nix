{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "4c67f48";
    sha256 = "10l5m21qa62lqla72q0zjszgbwjmq08zjv2v7mdscdvcxlqd1dfd";
  };
}
