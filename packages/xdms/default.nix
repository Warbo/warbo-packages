{
  gnumake,
  lhasa,
  stdenv,
}:

stdenv.mkDerivation rec {
  name = "xdms";
  src = builtins.fetchurl {
    url = "http://aminet.net/util/arc/xDMS.lha";
    sha256 = "0f1fs9nlcqggix5iziadk5qc2pqxx6wsm0ixd9hdncvrygs67ffq";
  };
  buildInputs = [
    lhasa
    gnumake
  ];
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
