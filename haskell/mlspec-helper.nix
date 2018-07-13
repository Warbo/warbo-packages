self: super: helf: huper:

helf.callPackage (self.haskellGit {
  url    = "${self.repoSource or self.defaultRepo}/mlspec-helper.git";
  stable = {
    rev    = "d794706";
    sha256 = "0vlr3ar1zwk0ykbzmg47j1yv1ba8gf6nzqj10bfy60nii91z7slh";
  };
}) {}
