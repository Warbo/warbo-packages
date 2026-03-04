{
  fetchGitIPFS,
  git-on-ipfs-tree ? {
    # git-ref: pkipfs::y5a9inx61aski4miz4sgmg55qgbazxhfwab3i6ee1ypa6rnumi8o master^{tree}
    sha1 = "ff31e285c14f8d9d5e81234d79349a3a0a522a19";
  },
  newScope,
  nixpkgs ? pkgs.path,
  pkgs,
  ...
}@args:
newScope (args // { inherit nixpkgs pkgs; }) (fetchGitIPFS git-on-ipfs-tree) { }
