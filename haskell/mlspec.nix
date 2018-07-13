self: super: helf: huper:

helf.callPackage (self.haskellGit {
  url    = "${self.repoSource or self.defaultRepo}/mlspec.git";
  stable = {
    rev    = "8f97e7f";
    sha256 = "1ay4zw55k659cdpg1mbb3jcdblabyajpj657v4fc6wvydqvia6d5";
  };
}) {}
