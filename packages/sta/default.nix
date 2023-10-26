{ autoconf, automake, getSource, stdenv }:

stdenv.mkDerivation rec {
  name = "sta";
  src = getSource { inherit name; };
  buildInputs = [ autoconf automake ];
  preConfigure = "./autogen.sh";
}
