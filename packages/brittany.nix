{ hasBinary, haskellPackages }:

rec {
  pkg   = haskellPackages.brittany;
  tests = hasBinary pkg "brittany";
}
