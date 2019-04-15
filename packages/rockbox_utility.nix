{ lib, nixpkgs1709, super, zlib }:

with rec {
  downgradeQt = drv: drv.override (old: {
    inherit (nixpkgs1709.qt5) qtbase qmake qttools;
  });

  addZlib = drv: lib.overrideDerivation drv (old: {
    buildInputs = old.buildInputs ++ [ zlib ];
  });
};
{
  pkg = addZlib (downgradeQt super.rockbox_utility);
}
