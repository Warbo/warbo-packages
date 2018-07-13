self: super: helf: huper:

helf.callPackage (self.haskellGit {
  url    = "${self.repoSource or self.defaultRepo}/arbitrary-haskell.git";
  stable = {
    rev    = "d3fe986";
    sha256 = "07lb8q4kpfxv0fn7xhda763q7pjil2i3c43wfpwqrfv98f9yifqb";
  };
}) {}
