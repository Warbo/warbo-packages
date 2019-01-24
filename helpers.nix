{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "d9c317e";
    sha256 = "1q1b0x10ma40sfr9jvhi7ybd3gx5i7wykmnahxzwqlldzj4ixmj1";
  };
}
