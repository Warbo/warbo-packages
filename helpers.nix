{ nixpkgs ? import <nixpkgs> { config = {}; overlays = []; } }:
nixpkgs.fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "3f34310";
  sha256 = "170fmx8yk21x8imdg4qf3g6np42wqrzq3i1rfc6ssqrsbqm0wbic";
}
