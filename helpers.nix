{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "39dbfb3";
    sha256 = "1nvrirqk2x0bqsqdkaavh2629z21ipr68ahyr17a06m4k8sjmp32";
  };
}
