{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "110936c";
    sha256 = "1iiwsszw651hykf21j4183w0d8nx4jxk0p5db3hpgxzhnihi50jg";
  };
}
