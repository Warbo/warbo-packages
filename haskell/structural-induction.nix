self: super: helf: huper:

helf.callPackage (self.runCabal2nix {
  url = "cabal://structural-induction-0.3";
}) {}
