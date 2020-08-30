{ git2html-real, gitSource, hasBinary, stdenv }:

rec {
  pkg = stdenv.lib.overrideDerivation git2html-real (old: {
    src = gitSource { name = "git2html"; };
  });

  tests = hasBinary pkg "git2html";
}
