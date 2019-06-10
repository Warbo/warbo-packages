{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "1360d7c";
    sha256 = "08xx2mxp7grdb318py2fb5nd8g9j602r4pxj1lgjqzbj4xz0r1g2";
  };
}
