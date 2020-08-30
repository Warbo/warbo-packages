{ autoconf, automake, getSource, libtool, stdenv }:

{
  pkg = stdenv.mkDerivation rec {
    name           = "lhasa";
    src            = getSource { inherit name; };
    buildInputs    = [ autoconf automake libtool ];
    installFlags   = "prefix=$(out)";
    configurePhase = ''
      ./autogen.sh
    '';
  };
  tests = {};
}
