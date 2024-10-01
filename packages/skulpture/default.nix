{ qt5, qt6 }:
{
  qt5 = qt5.callPackage ./qt5.nix { };
  qt6 = qt6.callPackage ./qt6.nix { };
}
