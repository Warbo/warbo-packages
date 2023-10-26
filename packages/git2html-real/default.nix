{ getSource, hasBinary, stdenv }:

# FIXME: This packages shouldn't have to exist
stdenv.mkDerivation {
  name = "git2html";
  src = getSource { name = "git2html-real"; };
  installPhase = ''
    mkdir -p "$out/bin"
    cp git2html.sh "$out/bin/git2html"
  '';
}
