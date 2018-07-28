self: super: helf: huper:

helf.callPackage (self.haskellGit {
  url    = "${self.repoSource or self.defaultRepo}/ghc-dup.git";
  stable = {
    rev        = "f30658f";
    sha256     = "06jfb7ywny0lm7f1frcysnwf39ba675wqbnfjzmgd7iv1pc2rk7l";
    unsafeSkip = false;
  };
}) {}
