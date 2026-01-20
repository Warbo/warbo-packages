{ callPackage, fetchGitIPFS, multibase-cli }:
with {
  src = fetchGitIPFS { sha1 = "11d7565b62d384f254e06cb30ba18ad62ebe4722"; };
};
callPackage src { inherit multibase-cli; }
