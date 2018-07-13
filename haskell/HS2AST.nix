self: super: helf: huper:

self.haskellGit {
  url    = "${self.repoSource or self.defaultRepo}/hs2ast.git";
  stable = {
    rev    = "f48063e";
    sha256 = "1jg62a71mlnm0k2sjbjhf3n5q2c4snlbaj5dlrhdg44kxiyilx9x";
  };
}
