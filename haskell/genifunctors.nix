self: super: helf: huper:

helf.callPackage (self.haskellSrc2nix rec {
  name = "genifunctors";
  src = self.gitSource { inherit name; };
}) { }
