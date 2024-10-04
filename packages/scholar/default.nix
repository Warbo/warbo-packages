{ python3, stdenv }:

stdenv.mkDerivation rec {
  name = "scholar.py";
  src = builtins.fetchGit {
    url = "https://github.com/ckreibich/scholar.py.git";
    rev = "7e6efb47e8c9d4babd613f5baca7c2a5dc424678";
  };

  propagatedBuildInputs = [ (python3.withPackages (p: [ p.beautifulsoup4 ])) ];

  installPhase = ''
    mkdir -p "$out/bin"
    cp scholar.py "$out/bin/"

    mkdir -p "$out/share/doc/scholar.py"
    cp README.md "$out/share/doc/scholar.py"
  '';
}
