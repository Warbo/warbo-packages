{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "027e227";
    sha256 = "11niics6rq60zaicb6spkfpvp8nv3wszdfgpqnrml946p1bggy13";
  };
}
