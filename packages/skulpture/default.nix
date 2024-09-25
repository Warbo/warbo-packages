{
  cmake,
  extra-cmake-modules,
  libsForQt5,
  qt5,
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
  };
}
