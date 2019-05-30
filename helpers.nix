{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "f834fbb";
    sha256 = "0pcaml246lkbdd29svsxhld50d4sbd1dqvacs9aj1wgyhhy53537";
  };
}
