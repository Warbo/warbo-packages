{ nixpkgs ? import <nixpkgs> { config = {}; overlays = []; } }:
nixpkgs.fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "9fc3a6b";
  sha256 = "147zffc8bcvd869dh8snz4rk8y53v4zhxzid9pfp89p2fbhvxb6c";
}
