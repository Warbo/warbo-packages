{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "d80c739";
    sha256 = "07wx59vsmm0yl8mi64bndf9bk0zc320s5yj8h9nx05hdyd8w5rfg";
  };
}
