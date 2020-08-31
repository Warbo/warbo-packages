{ gitSource, path }:

import "${gitSource { name = "asv-nix"; }}" { inherit path; }
