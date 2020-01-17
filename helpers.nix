{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "7e90bc1";
    sha256 = "1saymxilrnbi8vlw6p868cahhhmfj8bn28irbfl3vaynvsv6qn1b";
  };
}
