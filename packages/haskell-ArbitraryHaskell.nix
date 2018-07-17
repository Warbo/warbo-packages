{ haskellPackages, haskellRelease, unpack }:

haskellRelease {
  name        = "ArbitraryHaskell";
  dir         = unpack haskellPackages.ArbitraryHaskell.src;
  hackageSets = { nixpkgs1709 = [ "ghc7103" ]; };
}
