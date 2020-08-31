{ getSource, stdenv }:

stdenv.mkDerivation rec {
  name         = "citation-styles";
  src          = getSource { inherit name; };
  installPhase = ''
    mkdir -p "$out/lib/styles"
    cp *.csl "$out/lib/styles/"
  '';
}
