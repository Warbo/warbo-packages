{ hasBinary, nixpkgs1803 }:

rec {
  pkg   = nixpkgs1803.haskellPackages.brittany;
  tests = hasBinary pkg "brittany";
}
