{
  cmake,
  extra-cmake-modules,
  qt6,
  stdenv,
  enableSkulptureGui ? false,
}:
stdenv.mkDerivation {
  name = "skulpture-qt6";
  src = import ./source.nix;
  buildInputs = [
    cmake
    qt6.qmake
    qt6.qtbase
  ];
  dontWrapQtApps = "1";
  preConfigure = ''
    cmakeFlagsArray+=(
      "-DUSE_QT6=ON"
      "-DUSE_GUI_CONFIG=${if enableSkulptureGui then "ON" else "OFF"}"
      "-DDATA_INSTALL_DIR=$out/usr/share"
    )
  '';
}
