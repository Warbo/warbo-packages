{ warbo-packages-sources ? (import ./warbo-packages-sources.nix {}).pkg }:

{
  pkg   = import warbo-packages-sources.nix-helpers.outPath;
  tests = {};
}
