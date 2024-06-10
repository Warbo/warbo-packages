{ callCabal2nixWithPlan, nixpkgs2311 }:

callCabal2nixWithPlan {
  name = "GetDeps";
  src = fetchGit {
    url = "http://github.com/Warbo/GetDeps.git";
    ref = "master";
    rev = "4ce5787d28a82401cee52d67ac20c10ca0f2d57f";
  };
  haskellPackages = nixpkgs2311.haskell.packages.ghc884;
}
