{ fetchFromGitHub, pkgs }:
with {
  src = fetchFromGitHub {
    owner = "Warbo";
    repo = "nixos-shell";
    rev = "ba539391095a31eb31d27aed6fb27d0ea3a89e72";
    hash = "sha256-y59zNfqrEM8q59t6mzFeyVfaUfHRkbcdsI1Kk2AGPRU=";
  };
};
import src { inherit pkgs; }
