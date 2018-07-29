self: super: helf: huper:

with rec {
  thfSrc = self.runCommand "thf-src"
    {
      src  = self.tipSrc;
      expr = "import Options.Applicative";
    }
    ''
      D="$src/tip-haskell-frontend"
      [[ -d "$D" ]] || {
        echo "Couldn't find '$D'" 1>&2
        find . 1>&2
        env 1>&2
        exit 1
      }
      cp -ar "$D" "$out"
      chmod +w -R "$out"

      for F in executable/Main.hs src/Tip/Params.hs
      do
        sed -e "s/$expr/$expr\nimport Data.Semigroup/g" \
            -i "$out/$F"
      done

      sed -e 's/optparse-applicative,/optparse-applicative, semigroups,/g' \
          -i "$out/tip-haskell-frontend.cabal"
  '';

  thf = helf.callPackage (self.runCabal2nix { url = thfSrc; }) {};
};
self.haskell.lib.doJailbreak thf
