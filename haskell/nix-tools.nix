self: super: helf: huper:

helf.callPackage (self.haskellSrc2nix {
  name = "nix-tools";
  src  = self.fetchFromGitHub {
    owner  = "input-output-hk";
    repo   = "nix-tools";
    rev    = "bb5700d";
    sha256 = "11q34s5hm76vb6r01h3r5ya9k9f4xqz2xdf958frhn6jb3jjihf6";
  };
}) {}
