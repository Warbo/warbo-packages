{ buildEnv, fetchFromGitLab, hsinspect, run }:

with {
  code = run {
    name   = "haskell-tng.el";
    vars   = {
      dir  = "share/emacs/site-lisp/haskell-tng.el";
      repo = fetchFromGitLab {
        owner  = "tseenshe";
        repo   = "haskell-tng.el";
        rev    = "13102763";
        sha256 = "15xczywy14xyqnm1n8fbqr1cqbbqp44ds3n6smyb01xg4dhnf2wq";
      };
    };
    script = ''
      mkdir -p "$(dirname "$out/$dir")"
      ln -s "$repo" "$out/$dir"
    '';
  };
};
{
  pkg = buildEnv {
    name  = "haskell-tng";
    paths = [ code hsinspect ];
  };
  tests = {};
}
