{ fetchGitIPFS, nixpkgs }:
with {
  src = fetchGitIPFS { sha1 = "34effe4225c72833910554110a41f7f92c5c194c"; };
};
import src { inherit nixpkgs; }
