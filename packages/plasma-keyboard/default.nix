{
  lib,
  fetchTreeFromGitHub,
  extra-cmake-modules,
  kdePackages,
  qt6,
}:

with {
  inherit (kdePackages)
    mkKdeDerivation
    kwayland
    kservice
    kglobalaccel
    kirigami
    kcmutils
    ;
  inherit (qt6)
    qtbase
    qtdeclarative
    qtsvg
    qtwayland
    qtvirtualkeyboard
    ;
};

mkKdeDerivation rec {
  pname = "plasma-keyboard";
  version = "ef139d0ea7c89af022382353c38a966cbcfd83df";

  src = fetchTreeFromGitHub {
    owner = "KDE";
    repo = "plasma-keyboard";
    tree = version;
  };

  extraNativeBuildInputs = [
    extra-cmake-modules
    qtwayland
    kdePackages.kcmutils # Moved kcmutils to native build inputs
  ];

  extraBuildInputs = [
    qtbase
    qtdeclarative
    qtsvg
    qtvirtualkeyboard
    kwayland
    kservice
    kglobalaccel
    kirigami
  ];

  meta = with lib; {
    description = "Plasma Keyboard";
    homepage = "https://invent.kde.org/plasma/plasma-keyboard";
    license = licenses.lgpl21Plus;
  };
}
