{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "085fe11";
    sha256 = "04p0lf9yi1din4r0fy124cmxnxlisdk58xgvnjmw2k29ax7gjir8";
  };
}
