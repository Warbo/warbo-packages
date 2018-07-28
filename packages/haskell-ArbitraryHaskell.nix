{ nothing, haskellPackages, haskellRelease, unpack' }:

with {
  all = haskellRelease rec {
    name         = "ArbitraryHaskell";
    dir          = unpack' "ArbitraryHaskell"
                           haskellPackages.ArbitraryHaskell.src;
    extraSources = { ArbitraryHaskell = dir; };
    hackageSets  = { nixpkgs1709 = [ "ghc7103" ]; };
  };
};
#all.hackageDeps.nixpkgs1709.ghc7103
builtins.trace "FIXME: No ArbitraryHaskell package" nothing
