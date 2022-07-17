{ warboHaskellOverride, lib, super }:

super.haskell // {
  packages = lib.mapAttrs
    (_: haskellPackages: warboHaskellOverride { inherit haskellPackages; })
    super.haskell.packages;
}
