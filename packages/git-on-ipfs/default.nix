{
  fetchGitIPFS,
  git-on-ipfs-tree ? {
    # git-ref: pkipfs::y5a9inx61aski4miz4sgmg55qgbazxhfwab3i6ee1ypa6rnumi8o master^{tree}
    sha1 = "48fb2e0140036831afb351a104cf15607619daa9";
  },
  newScope,
  nixpkgs ? pkgs.path,
  pkgs,
  ...
}@args:
newScope (args // { inherit nixpkgs pkgs; }) (fetchGitIPFS git-on-ipfs-tree) { }
