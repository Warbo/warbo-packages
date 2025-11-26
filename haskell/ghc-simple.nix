self: _: helf: _:

helf.callPackage (self.haskellSrc2nix rec {
  name = "ghc-simple";
  src = self.getSource { inherit name; };
}) { }
