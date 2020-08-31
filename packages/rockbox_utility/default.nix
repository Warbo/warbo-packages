{ lib, super, zlib }:

lib.overrideDerivation super.rockbox_utility (old: {
  buildInputs = old.buildInputs ++ [ zlib ];
})
