{ gitSource, pkgs }:

import "${gitSource { name = "feed2maildir"; }}" { inherit pkgs; }
