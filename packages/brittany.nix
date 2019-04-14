{ fetchFromGitHub, hasBinary, haskellPackages }:

with {
  src = fetchFromGitHub {
    owner  = "lspitzner";
    repo   = "brittany";
    rev    = "21ef8b2";
    sha256 = "0xcf6rp90m34y72fijblcmsdwwwl3g6jbw1g4yc3r5cb8rpks82p";
  };
};
rec {
  pkg = with haskellPackages;
        callPackage (haskellSrc2nix {
                      inherit src;
                      name = "brittany";
                    })
                    {};

  tests = hasBinary pkg "brittany";
}
