self: super: helf: huper:

with self;
with rec {
  gpSrc = fetchFromGitHub {
    owner  = "danr";
    repo   = "geniplate";
    rev    = "961a732";
    sha256 = "1ws5v1md552amcs7hhg4cla1sbq9lh3imqjiz8byvsp8bgrn4xvf";
  };

  patched = runCommand "patch-geniplate" { inherit gpSrc; } ''
    cp -r "$gpSrc" ./toPatch
    chmod 777 -R ./toPatch

    sed -e 's/geniplate-mirror/geniplate/g' < "toPatch/geniplate-mirror.cabal" \
                                            > "toPatch/geniplate.cabal"
    rm "toPatch/geniplate-mirror.cabal"

    cp -r ./toPatch "$out"
  '';

  ghcVersion = helf.ghc.version;
  ghcBelow   = "7.10";
};

assert builtins.compareVersions ghcVersion ghcBelow == -1 || self.die {
  inherit ghcVersion;
  error = "geniplate needs GHC below ${ghcBelow} due to template-haskell bound";
};
helf.callPackage (haskellSrc2nix {
                   name = "geniplate";
                   src  = patched;
                 }) {}
