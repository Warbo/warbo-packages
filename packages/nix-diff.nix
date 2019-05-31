{ nixpkgs1803, super }:

{
  pkg   = super.nix-diff or nixpkgs1803.nix-diff;
  tests = {};
}
