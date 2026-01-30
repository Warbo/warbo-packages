{
  callPackage,
  fetchGitIPFS,
  multibase-cli,
}:
with {
  src = fetchGitIPFS { sha1 = "95a250b6693b4440cb11db11dbbb11be857549c9"; };
};
callPackage src { inherit multibase-cli; }
