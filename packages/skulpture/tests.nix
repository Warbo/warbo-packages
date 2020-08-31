{ nixpkgs1909, skulpture }:

{
  qt5Lib = nixpkgs1909.libsForQt5.callPackage skulpture.mkSkulptureQt5 {};
}
