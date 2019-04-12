{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "b4859ba";
    sha256 = "162vm2gzwrlkv3yhpmx0jpdz305635qqsqcr6lvjbkxxh875bxfk";
  };
}
