{ getSource, stdenv }:

stdenv.mkDerivation rec {
  name = "bibtool";
  src = getSource { inherit name; };
}
