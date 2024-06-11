self: super: helf: huper:

with {
  patch =
    gpSrc:
    self.runCommand "patch-geniplate" { inherit gpSrc; } ''
      cp -r "$gpSrc" ./toPatch
      chmod 777 -R ./toPatch

      sed -e 's/geniplate-mirror/geniplate/g' < "toPatch/geniplate-mirror.cabal" \
                                              > "toPatch/geniplate.cabal"
      rm "toPatch/geniplate-mirror.cabal"

      cp -r ./toPatch "$out"
    '';

  ghcVersion = helf.ghc.version;
  ghcBelow = "7.10";
};

assert
  builtins.compareVersions ghcVersion ghcBelow == -1
  || self.die {
    inherit ghcVersion;
    error = "geniplate needs GHC below ${ghcBelow} due to template-haskell bound";
  };
helf.callPackage (self.haskellSrc2nix rec {
  name = "geniplate";
  src = patch (self.getSource { inherit name; });
}) { }
