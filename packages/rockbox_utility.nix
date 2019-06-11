{ lib, qt5, super, zlib }:

with rec {
  propagateQt = drv: builtins.trace
    "TODO: Stop propagating Qt5 into rockbox_utility when Qt5 is fixed"
    drv.override (old: { inherit (qt5) qtbase qmake qttools; });

  addZlib = drv: lib.overrideDerivation drv (old: {
    buildInputs = old.buildInputs ++ [ zlib ];
  });
};
{
  pkg   = addZlib (propagateQt super.rockbox_utility);
  tests = {};
}
