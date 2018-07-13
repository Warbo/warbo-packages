self: super: helf: huper:

with {
  thfSrc = self.runCommand "thf-src" { src = self.tipSrc; } ''
    D="$src/tip-haskell-frontend"
    [[ -d "$D" ]] || {
      echo "Couldn't find '$D'" 1>&2
      find . 1>&2
      env 1>&2
      exit 1
    }
    cp -ar "$D" "$out"
  '';
};
helf.callPackage (self.nixFromCabal thfSrc null) {}
