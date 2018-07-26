self: super: helf: huper:

helf.callPackage (self.runCabal2nix {
  url = self.unpack (self.fetchurl {
    url    = "https://hackage.haskell.org/package/panpipe-0.2.0.0/panpipe-0.2.0.0.tar.gz";
    sha256 = "0kdkw7y6hvdv3lz4fhq4x0f7y397753dw5mjp4gw03qnrz3nchxp";
  });
}) {
  mkDerivation = args: helf.mkDerivation
    (removeAttrs args [ "benchmarkHaskellDepends" ]);
}
