{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "7a2939a";
    sha256 = "02h9l766yp8g07hh8rj5pilicxmc1p7kswm4699bbm16cn12yv9a";
  };
}
