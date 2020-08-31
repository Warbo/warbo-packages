{ autoconf, automake, getSource, flex, libtool, stdenv }:

stdenv.mkDerivation rec {
  name         = "miller";
  src          = getSource { inherit name; };
  buildInputs  = [ autoconf automake flex libtool ];
  preConfigure = ''
    autoreconf -fiv
  '';
}
