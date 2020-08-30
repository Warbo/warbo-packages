{ gitSource }:

with rec {
  src  = gitSource { name = "panhandle"; };
  pkgs = import "${src}/release.nix";
};
{
  pkg   = pkgs.exes.panhandle;
  tests = pkgs.tests;
}
