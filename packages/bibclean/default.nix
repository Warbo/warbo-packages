{ getSource, stdenv }:

stdenv.mkDerivation rec {
  name = "bibclean";
  src = getSource { inherit name; };
  preInstall = ''
    mkdir -p "$out/bin"
    mkdir -p "$out/man/man1"
  '';
}
