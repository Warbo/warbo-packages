{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "25a03d3";
    sha256 = "1sjsjp9slaf3zdjb7w0689si5bzm5ln8bihi16g36n89q4l4z3rd";
  };
}
