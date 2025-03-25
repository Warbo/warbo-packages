{ fetchTreeFromGitHub, pkgs }:
with {
  src = fetchTreeFromGitHub {
    owner = "Warbo";
    repo = "nixos-shell";
    tree = "dc684c8e9f8d10e43196c0eeb1e9ada156d6792b";
  };
};
import src { inherit pkgs; }
