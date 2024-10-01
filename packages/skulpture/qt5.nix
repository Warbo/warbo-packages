{
  cmake,
  extra-cmake-modules,
  libsForQt5,
  qt5,
}:

qt5.mkDerivation {
  inherit (qt5.qtbase) qtPluginPrefix;
  name = "skulpture-qt5";
  src = import ./source.nix;
  buildInputs = [
    cmake
    extra-cmake-modules
    qt5.qmake
    qt5.qtbase
    libsForQt5.kdelibs4support
  ];
  preConfigure = ''
    cmakeFlagsArray+=(
      "-DUSE_QT6=OFF"
      "-DUSE_GUI_CONFIG=OFF"
      "-DQT_PLUGINS_DIR=$out/$qtPluginPrefix"
    )
  '';
}
