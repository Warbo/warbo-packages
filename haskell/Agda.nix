self: super: helf: huper:

with builtins;
with rec {
  haveAgda = huper ? Agda;

  agdaWorks = haveAgda && (tryEval huper.Agda).success;

  warning = ''
    WARNING: Haskell Agda package seems to work upstream; our override might not
    be needed anymore.
  '';

  warner = if agdaWorks then trace warning else (x: x);
};

warner helf.callPackage (self.runCabal2nix {
  url = self.unpack self.nixpkgs1609.haskellPackages.Agda.src;
}) {}
