{ getSource, hsPkgs ? nixpkgs1803.haskellPackages, haskellSrc2nix, lib,
  nixpkgs1803 }:

hsPkgs.callPackage (haskellSrc2nix rec {
  name = "nix-delegate";
  src  = getSource { inherit name; };
}) {}
