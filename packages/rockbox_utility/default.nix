{ lib, stdenv, super, zlib }:

if stdenv.isDarwin
   then null
   else lib.overrideDerivation super.rockbox_utility (old: {
     buildInputs = old.buildInputs ++ [ zlib ];
   })
