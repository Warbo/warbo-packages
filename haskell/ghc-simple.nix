self: super: helf: huper:

helf.callPackage (self.haskellSrc2nix rec {
  name = "ghc-simple";
  src = self.getSource { inherit name; };
}) { }
