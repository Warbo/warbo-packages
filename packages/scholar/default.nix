{ python3, stdenv }:

stdenv.mkDerivation rec {
  name = "scholar.py";
  src = builtins.fetchGit {
    url = "https://github.com/ckreibich/scholar.py.git";
    rev = "3f889d9c31cda4bd041963c7dd689009f8ae2d42";
  };

  propagatedBuildInputs = [ (python3.withPackages (p: [ p.beautifulsoup4 ])) ];

  installPhase = ''
    mkdir -p "$out/bin"
    cp scholar.py "$out/bin/"

    mkdir -p "$out/share/doc/scholar.py"
    cp README.md "$out/share/doc/scholar.py"
  '';
}
