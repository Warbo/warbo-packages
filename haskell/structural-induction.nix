self: super: helf: huper:

helf.callPackage (self.runCabal2nix {
  name = "structural-induction";
  url  = "cabal://structural-induction-0.3";
}) {}
