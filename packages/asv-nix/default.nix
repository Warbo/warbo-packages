{ gitSource, hasBinary, path }:

with {
  src = gitSource { name = "asv-nix"; };
};
rec {
  pkg   = import "${src}" { inherit path; };
  tests = hasBinary pkg "asv";
}
