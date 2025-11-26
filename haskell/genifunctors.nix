self: _: helf: _:

helf.callPackage (self.haskellSrc2nix rec {
  name = "genifunctors";
  src = self.gitSource { inherit name; };
}) { }
