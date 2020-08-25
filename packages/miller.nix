{ autoconf, automake, getSource, hasBinary, flex, libtool, stdenv }:

rec {
  pkg = stdenv.mkDerivation rec {
    name         = "miller";
    src          = getSource { inherit name; };
    buildInputs  = [ autoconf automake flex libtool ];
    preConfigure = ''
      autoreconf -fiv
    '';
  };

  tests = hasBinary pkg "mlr";
}
