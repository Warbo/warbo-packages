{
  git2html-real,
  gitSource,
  lib,
}:

lib.overrideDerivation git2html-real (old: {
  src = gitSource { name = "git2html"; };
})
