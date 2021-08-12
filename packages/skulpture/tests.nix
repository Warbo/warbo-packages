{ nixpkgs1909, skulpture, stdenv }:

if stdenv.isDarwin then {} else {
  qt5Lib = nixpkgs1909.libsForQt5.callPackage skulpture.mkSkulptureQt5 {};
}
