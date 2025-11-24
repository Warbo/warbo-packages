{
  fetchGitIPFS,
  mainline-mut-tree ? { sha1 = "e2a0111dacf7afcfe5adbc380af7cabead1ec3e2"; },
  pkgs,
}:
import (fetchGitIPFS mainline-mut-tree) {
  inherit pkgs;
}
