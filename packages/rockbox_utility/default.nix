# TODO: Is this fix still needed?
{
  nixpkgs-lib,
  nixpkgs,
  zlib,
}:

nixpkgs-lib.overrideDerivation nixpkgs.rockbox-utility (old: {
  buildInputs = old.buildInputs ++ [ zlib ];
})
