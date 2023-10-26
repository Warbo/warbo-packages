{ getSource, python3, stdenv }:

stdenv.mkDerivation rec {
  name = "scholar.py";
  src = getSource { inherit name; };

  propagatedBuildInputs = [ (python3.withPackages (p: [ p.beautifulsoup4 ])) ];

  installPhase = ''
    mkdir -p "$out/bin"
    cp scholar.py "$out/bin/"

    mkdir -p "$out/share/doc/scholar.py"
    cp README.md "$out/share/doc/scholar.py"
  '';
}
