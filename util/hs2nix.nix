{ nixpkgs1803 }:

helf:
  # Fall back to nixpkgs 18.03 if our version is too old to have haskellSrc2nix
  helf.haskellSrc2nix or nixpkgs1803.haskellPackages.haskellSrc2nix
