{ lib, skipMac, super, zlib }:

skipMac "rockbox_utility" (lib.overrideDerivation super.rockbox_utility (old: {
  buildInputs = old.buildInputs ++ [ zlib ];
}))
