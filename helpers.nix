{ nixpkgs ? import <nixpkgs> { config = {}; overlays = []; } }:
import (nixpkgs.fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "46348ac";
  sha256 = "13wjrli7wv9da4rhcnqh1g8z0nc2x0mq6wli1fmazw9759lky53m";
})
