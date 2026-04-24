{
  fetchGitIPFS,
  git-on-ipfs-tree ? {
    # multiaddr: /ipns/master.y5a9inx61aski4miz4sgmg55qgbazxhfwab3i6ee1ypa6rnumi8o/tree
    sha1 = "sha1-Vlg+ga+vNQZNgeW63vB3rRmC+lg=";
  },
  newScope,
  nixpkgs ? pkgs.path,
  pkgs,
  ...
}@args:
newScope (args // { inherit nixpkgs pkgs; }) (fetchGitIPFS git-on-ipfs-tree) { }
