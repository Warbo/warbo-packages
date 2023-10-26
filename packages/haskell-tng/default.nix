{ buildEnv, getSource, hsinspect, run }:

with {
  code = run rec {
    name = "haskell-tng.el";
    vars = {
      dir = "share/emacs/site-lisp/haskell-tng.el";
      repo = getSource { inherit name; };
    };
    script = ''
      mkdir -p "$(dirname "$out/$dir")"
      ln -s "$repo" "$out/$dir"
    '';
  };
};
buildEnv {
  name = "haskell-tng";
  paths = [ code hsinspect ];
}
