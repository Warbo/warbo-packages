self: super: helf: huper:

helf.callPackage (self.haskellSrc2nix rec {
  name = "nix-tools";
  src  = self.getSource { inherit name; };
}) {}
