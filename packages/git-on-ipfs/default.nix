{
  fetchGitIPFS,
  git-on-ipfs-tree ? {
    sha1 = "a71ad9a934b9fca17f316ab3416d57fc3e0afedc";
  },
  pkgs,
  warbo-packages,
}:
import (fetchGitIPFS git-on-ipfs-tree) {
  inherit pkgs warbo-packages;
  nixpkgs = pkgs.path;
}
