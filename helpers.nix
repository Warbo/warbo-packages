{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "ea05a22";
    sha256 = "1v7k4jrqqvfbnnyjlqk685qg8sym7vlcp3vhnbia8qlzcka9j29x";
  };
}
