{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "2b45d1a";
    sha256 = "07z78zqldr9xrynqds4ky0xfil1pa2l4zbw16298x1nmma20crjr";
  };
}
