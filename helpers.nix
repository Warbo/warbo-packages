{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "5f96c3b";
    sha256 = "1lr6wkadizjismlcpnz7mvd5fbgvqsdjhf98fyc3xaa2nnv71xwq";
  };
}
