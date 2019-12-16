{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "6f69b42";
    sha256 = "1qr5ngjz5dm2hxy1mmmjqy6nli1lg29bp2hkqn82mqhkh1b3dh6c";
  };
}
