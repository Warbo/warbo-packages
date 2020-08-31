{ getSource, gnumake, lhasa, stdenv }:

stdenv.mkDerivation rec {
  name        = "xdms";
  src         = getSource { inherit name; };
  buildInputs = [ lhasa gnumake ];
  unpackPhase = ''
    lha x "$src"
  '';
  buildPhase = ''
    cd xdms/src
    make
  '';
  installPhase = ''
    cd ..
    mkdir -p "$out/bin"
    cp src/xdms "$out/bin"
    cp Linux-bin/readdisk "$out/bin"
  '';
}
