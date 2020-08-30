{ getSource, hasBinary, stdenv }:

rec {
  pkg = stdenv.mkDerivation {
    name         = "git2html";
    src          = getSource { name = "git2html-real"; };
    installPhase = ''
      mkdir -p "$out/bin"
      cp git2html.sh "$out/bin/git2html"
    '';
  };

  tests = hasBinary pkg "git2html";
}
