{ getSource, nixpkgs1609, stdenv }:

stdenv.lib.overrideDerivation nixpkgs1609.coq (oldAttrs : rec {
  name = "coq-mtac";
  src  = getSource { inherit name; };
})
