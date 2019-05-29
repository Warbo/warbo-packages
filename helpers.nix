{ fetchgit ? (import <nixpkgs> { config = {}; overlays = []; }).fetchgit }:
{
  nix-helpers = fetchgit {
    url    = http://chriswarbo.net/git/nix-helpers.git;
    rev    = "d89d621";
    sha256 = "1mgkg9rklsnvzpl0mpq0475mv47wi2iaahs31xkhrf6vmvrv33b5";
  };
}
