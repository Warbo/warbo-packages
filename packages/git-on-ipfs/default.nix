{
  fetchGitIPFS,
  git-on-ipfs-tree ? {
    sha1 = "033b520f6871784e0a25e3890559aa18132725c3";
  },
  pkgs,
  warbo-packages,
}:
import (fetchGitIPFS git-on-ipfs-tree) {
  inherit pkgs warbo-packages;
  nixpkgs = pkgs.path;
}
