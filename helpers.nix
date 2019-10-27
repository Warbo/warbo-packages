{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "7c3a983";
    sha256 = "1hhwhwm5nf0d3r4x9rd9hkm5xhmfk43gcwzc4caiglc02m4snhvg";
  };
}
