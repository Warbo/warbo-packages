{ haskellOverride, lib, super }:

super.haskell // {
  packages = lib.mapAttrs
    (_: haskellPackages: haskellOverride { inherit haskellPackages; })
    super.haskell.packages;
}
