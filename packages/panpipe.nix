{ gitSource }:

with rec {
  src  = gitSource { name = "panpipe"; };
  pkgs = import src;
};
{
  pkg   = pkgs.panpipe.components.exes.panpipe;
  tests = pkgs.panpipe.components.tests;
}
