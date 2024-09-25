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
  postInstall = ''
    mkdir -p "$out/$qtPluginPrefix/styles"
    mv /build/source/build/src/skulpture.so \
      "$out/$qtPluginPrefix/kstyle_skulpture_config.so"
    mv /build/source/build/src/config/kstyle_skulpture_config.so \
      "$out/$qtPluginPrefix/styles/skulpture.so"
  '';
}
