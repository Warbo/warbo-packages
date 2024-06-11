{
  nixpkgs1909,
  skulpture,
  skipMac,
}:

skipMac "skulpture tests" {
  qt5Lib = nixpkgs1909.libsForQt5.callPackage skulpture.mkSkulptureQt5 { };
}
