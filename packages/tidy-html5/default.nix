{ cmake, getSource, libxslt, stdenv }:

stdenv.mkDerivation rec {
  name = "tidy-html5";
  src = getSource { inherit name; };
  buildInputs = [ cmake libxslt ];
}
