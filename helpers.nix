{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "5b47822";
    sha256 = "0dyrzkyxdwkjk7dylcd3hwdpfv5m6lfnlay9vfm8qpmpidi5b4ch";
  };
}
