{ nixpkgs ? import <nixpkgs> { config = {}; overlays = []; } }:
nixpkgs.fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "640102c";
  sha256 = "1v8w012v7j2xg30dlh1i4y933v8ykiq3cc3xw4v92qv7pwfai4zf";
}
