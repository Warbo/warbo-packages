{ getSource, hasBinary, nixpkgs1609, stdenv }:

rec {
  pkg = stdenv.lib.overrideDerivation nixpkgs1609.coq (oldAttrs : rec {
    name = "coq-mtac";
    src  = getSource { inherit name; };
  });

  tests = hasBinary pkg "coqc";
}
