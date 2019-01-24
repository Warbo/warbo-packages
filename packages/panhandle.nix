{ hasBinary, haskellOverride, nixpkgs1609 }:

rec {
  pkg = (haskellOverride {
    haskellPackages = nixpkgs1609.haskell.packages.ghc7103;
    panPkgs         = true;
  }).panhandle;

  tests = {
    haveBinary = hasBinary pkg "panhandle";
  };
}
