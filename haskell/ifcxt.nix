self: super: helf: huper:

helf.callPackage (self.haskellGit {
  url    = "${self.repoSource or self.defaultRepo}/ifcxt.git";
  ref    = "constraints";
  stable = {
    rev    = "b4620ba";
    sha256 = "0gyk92bxg6nk02b6zkzvzx8k12pyca2cdj3v8wmi91v5kwzlay4y";
  };
}) {}
