{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "24590bf";
    sha256 = "0yd5lzbdb5md3cvijn02bhdfb0ql3nr9a69d11nrz1bpzxw8473n";
  };
}
