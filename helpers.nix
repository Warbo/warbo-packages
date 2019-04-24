{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "09f6312";
    sha256 = "0yhbqigijfcizygzqi116rpp1bvjn4x8x8bzpk8pkhgq1360vig1";
  };
}
