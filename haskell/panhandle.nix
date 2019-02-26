self: super: helf: huper:

# We currently use 0.2.x since its dependencies are in older nixpkgs sets
helf.callPackage (self.hs2nix helf {
  name = "panhandle";
  src  = self.unpack' "panhandle" (self.fetchurl {
    url    = "https://hackage.haskell.org/package/panhandle-0.2.1.0/panhandle-0.2.1.0.tar.gz";
    sha256 = "1m19bs5v1lrfhzdvzn4blrd5hfccmb1l3fl0892i1mnixdzs4wwc";
  });
}) {}
