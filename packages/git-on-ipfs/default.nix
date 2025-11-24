{
  fetchGitIPFS,
  git-on-ipfs-tree ? {
    sha1 = "3c09a6a28891d1f28ba8a210cbba36a7304042c3";
  },
  pkgs,
  warbo-packages,
}:
import (fetchGitIPFS git-on-ipfs-tree) {
  inherit pkgs warbo-packages;
  nixpkgs = pkgs.path;
}
