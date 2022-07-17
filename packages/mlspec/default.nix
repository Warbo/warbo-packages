{ warboHaskellOverride, nixEvalOverrides, nixpkgs1803, skipMac }:

skipMac "mlspec" (warboHaskellOverride {
  haskellPackages = nixpkgs1803.haskell.packages.ghc7103;
  filepath        = true;
  extra           = nixEvalOverrides;
}).mlspec
