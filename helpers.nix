{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "f34c211";
    sha256 = "0qh8467bc05l8gq8mpkl9l7ln4n6f7sbdjpbv2cbq9v3shg89cgl";
  };
}
