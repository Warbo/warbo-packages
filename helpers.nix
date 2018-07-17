{ nixpkgs ? import <nixpkgs> { config = {}; overlays = []; } }:
nixpkgs.fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "4f50621";
  sha256 = "1c90yk10jrwx7g475i06jwc8xq92008x82zlldkbli8hb9gbl45n";
}
