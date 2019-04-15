{ nixpkgs1709, super }:

{
  pkg = super.rockbox_utility.override (old: {
    inherit (nixpkgs1709.qt5) qtbase qmake qttools;
  });
}
