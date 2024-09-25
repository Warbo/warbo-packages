{
  cmake,
  extra-cmake-modules,
  libsForQt5,
  qt5,
  qt6,
  stdenv,
}:
{
  qt5 = import ./qt5.nix {
    inherit
      cmake
      extra-cmake-modules
      libsForQt5
      qt5
      ;
  };
  qt6 = import ./qt6.nix {
    inherit
      cmake
      extra-cmake-modules
      qt6
      stdenv
      ;
  };
}
