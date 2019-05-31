{ nixpkgs1803, super }:

{
  pkg   = super.ddgr or nixpkgs1803.ddgr;
  tests = {};
}
