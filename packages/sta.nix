{ autoconf, automake, getSource, hasBinary, stdenv }:

rec {
  pkg = stdenv.mkDerivation rec {
    name         = "sta";
    src          = getSource { inherit name; };
    buildInputs  = [ autoconf automake ];
    preConfigure = "./autogen.sh";
  };

  tests = hasBinary pkg "sta";
}
