{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "347793a";
    sha256 = "0187zslf18hywf4rcj83s7hqxzsyqg4gb6kxa3ywcazv65d06pxg";
  };
}
