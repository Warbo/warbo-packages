{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "aa820eb";
    sha256 = "1685ysn5pnzna0bw5kr4bqdr2pda8n2xai9xlgg0rddaai855xiw";
  };
}
