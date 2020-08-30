{ cmake, getSource, hasBinary, libxslt, stdenv }:

rec {
  pkg = stdenv.mkDerivation rec {
    name        = "tidy-html5";
    src         = getSource { inherit name; };
    buildInputs = [ cmake libxslt ];
  };

  tests = hasBinary pkg "tidy";
}
