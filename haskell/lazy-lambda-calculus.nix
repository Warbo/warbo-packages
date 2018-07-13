self: super: helf: huper:

helf.callPackage (self.haskellGit {
  url    = "${self.repoSource or self.defaultRepo}/lazy-lambda-calculus.git";
  stable = {
    rev    = "6674552";
    sha256 = "1ill96m7ixy2yxdy1445nvdy6jrlg8fjwil4q07hiivprdj5xyh3";
  };
}) {}
