{ getSource, nixpkgs1609, stdenv }:

if stdenv.isDarwin
   then null
   else stdenv.lib.overrideDerivation nixpkgs1609.coq (oldAttrs : rec {
     name = "coq-mtac";
     src  = getSource { inherit name; };
   })
