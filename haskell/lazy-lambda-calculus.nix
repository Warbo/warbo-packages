self: super: helf: huper:

helf.callPackage (self.haskellGit {
  url    = "${self.repoSource or self.defaultRepo}/lazy-lambda-calculus.git";
  stable = {
    rev        = "d4dfba7";
    sha256     = "068cjb9wkqshyrjfg099zc8yp5s4q1ihnbby6hcs4d4r6z8fmchi";
    unsafeSkip = false;
  };
}) {}
