{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "79ce94a";
    sha256 = "1c4ck8l6vjgfqxxvp909i60s1y5ja0dsqyvq4ksppw1cs0nmgqp7";
  };
}
