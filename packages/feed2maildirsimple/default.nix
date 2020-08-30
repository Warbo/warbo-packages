{ gitSource, pkgs }:

with rec {
  src = gitSource { name = "feed2maildir"; };
};
{
  pkg   = import "${src}" { inherit pkgs; };
  tests = {};
}
