{ git2html-real, gitSource, stdenv }:

stdenv.lib.overrideDerivation git2html-real (old: {
  src = gitSource { name = "git2html"; };
})
