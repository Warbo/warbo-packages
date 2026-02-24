{
  fetchGitIPFS,
  git-on-ipfs-tree ? {
    # git-ref: pkipfs::y5a9inx61aski4miz4sgmg55qgbazxhfwab3i6ee1ypa6rnumi8o master^{tree}
    sha1 = "40a61e14a9f8660cccf1603c9dc5c744ebdb12fc";
  },
  newScope,
  nixpkgs ? pkgs.path,
  pkgs,
  ...
}@args:
newScope (args // { inherit nixpkgs pkgs; }) (fetchGitIPFS git-on-ipfs-tree) { }
