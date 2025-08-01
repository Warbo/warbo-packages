{
  lib,
  stdenv,
  fetchTreeFromGitHub,
  cmake,
  extra-cmake-modules,
  qtbase,
  qtdeclarative,
  qtsvg,
  qtwayland,
  kwayland,
  kcoreaddons,
  ki18n,
  kservice,
  kglobalaccel,
  kirigami2,
  plasma-framework,
}:

stdenv.mkDerivation rec {
  pname = "plasma-keyboard";
  version = "ef139d0ea7c89af022382353c38a966cbcfd83df";

  src = fetchTreeFromGitHub {
    owner = "KDE";
    repo = "plasma-keyboard";
    tree = version;
  };

  nativeBuildInputs = [
    cmake
    extra-cmake-modules
  ];

  buildInputs = [
    qtbase
    qtdeclarative
    qtsvg
    qtwayland
    kwayland
    kcoreaddons
    ki18n
    kservice
    kglobalaccel
    kirigami2
    plasma-framework
  ];
}
