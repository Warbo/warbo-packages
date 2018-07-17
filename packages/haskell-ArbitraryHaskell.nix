{ haskellPackages, haskellRelease, unpack }:

with {
  all = haskellRelease {
    name        = "ArbitraryHaskell";
    dir         = unpack haskellPackages.ArbitraryHaskell.src;
    hackageSets = { nixpkgs1709 = [ "ghc7103" ]; };
  };
};
all.hackageDeps.nixpkgs1709.ghc7103
