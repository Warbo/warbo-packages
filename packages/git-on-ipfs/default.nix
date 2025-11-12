{
  fetchGitIPFS,
  git-on-ipfs-tree ? {
    sha1 = "23508806ec0788d7f219788e7f0b8eb65b73e07b";
  },
  pkgs,
  warbo-packages,
}:
import (fetchGitIPFS git-on-ipfs-tree) {
  inherit pkgs warbo-packages;
  nixpkgs = pkgs.path;
}
