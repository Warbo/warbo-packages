{
  callPackage,
  overrides ? { },
  fetchGitIPFS,
  gns2dns-src ? fetchGitIPFS {
    sha1 = "sha1-rKGvxKl2Zb97qF26w6++PpMAHuQ=";
  },
}:
callPackage gns2dns-src overrides
