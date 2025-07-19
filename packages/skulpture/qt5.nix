{
  cmake,
  extra-cmake-modules,
  qtbase,
  qmake,
  wrapQtAppsHook,
  mkDerivation,
  libsForQt5,
  enableSkulptureGui ? false,
}:

mkDerivation {
  inherit (qtbase) qtPluginPrefix;
  name = "skulpture-qt5";
  src = import ./source.nix;
  buildInputs = [
    cmake
    extra-cmake-modules
    qmake
    qtbase
    libsForQt5.kdelibs4support
    wrapQtAppsHook
  ];
  preConfigure = ''
    cmakeFlagsArray+=(
      "-DUSE_QT6=OFF"
      "-DUSE_GUI_CONFIG=${if enableSkulptureGui then "ON" else "OFF"}"
      "-DQT_PLUGINS_DIR=$out/$qtPluginPrefix"
      "-DDATA_INSTALL_DIR=$out/usr/share"
    )
  '';
}
