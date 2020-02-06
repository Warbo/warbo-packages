{ lib, super, zlib }:

with rec {
  addZlib = drv: lib.overrideDerivation drv (old: {
    buildInputs = old.buildInputs ++ [ zlib ];
  });
};
{
  pkg   = addZlib super.rockbox_utility;
  tests = {};
}
