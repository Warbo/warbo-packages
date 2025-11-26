{
  fetchGitIPFS,
  git-on-ipfs-tree ? {
    sha1 = "3c09a6a28891d1f28ba8a210cbba36a7304042c3";
  },
  newScope,
  nixpkgs ? pkgs.path,
  pkgs,
  ...
}@args:
newScope args (fetchGitIPFS git-on-ipfs-tree) { }
