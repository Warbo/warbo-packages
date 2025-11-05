{
  fetchGitIPFS,
  git-on-ipfs-tree ? {
    sha1 = "9a062066f80299e7f42b6948ad716e5f64c1440c";
  },
  pkgs,
  warbo-packages,
}:
import (fetchGitIPFS git-on-ipfs-tree) {
  inherit pkgs warbo-packages;
  nixpkgs = pkgs.path;
}
