{ autoconf, automake, getSource, libtool, stdenv }:

stdenv.mkDerivation rec {
  name = "lhasa";
  src = getSource { inherit name; };
  buildInputs = [ autoconf automake libtool ];
  installFlags = "prefix=$(out)";
  configurePhase = ''
    ./autogen.sh
  '';
}
