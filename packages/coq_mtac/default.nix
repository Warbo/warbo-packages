{ getSource, nixpkgs1609, skipMac, stdenv }:

skipMac "coq-mtac"
  (stdenv.lib.overrideDerivation nixpkgs1609.coq (oldAttrs : rec {
    name = "coq-mtac";
    src  = getSource { inherit name; };
  }))
