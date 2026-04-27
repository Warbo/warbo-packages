{
  fetchGitIPFS,
  git-on-ipfs-tree ? {
    # multiaddr: /ipns/master.y5a9inx61aski4miz4sgmg55qgbazxhfwab3i6ee1ypa6rnumi8o/tree
    sha1 = "sha1-sRXSX+9/9stFRi70b5Qx528CFx0=";
  },
  newScope,
  nixpkgs ? pkgs.path,
  pkgs,
  ...
}@args:
newScope (args // { inherit nixpkgs pkgs; }) (fetchGitIPFS git-on-ipfs-tree) { }
