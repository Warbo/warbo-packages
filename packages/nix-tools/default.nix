{ getSource, haskell, warboHaskellOverride, isBroken, nixpkgs1903, skipMac,
  withDeps }:

with builtins;
with rec {
  inherit (haskell.lib) appendConfigureFlag dontCheck;
  testsFail = pkg: withDeps [(isBroken pkg)] (dontCheck pkg);
};
skipMac "nix-tools" (warboHaskellOverride {
  inherit (nixpkgs1903) haskellPackages;
  extra = [
    (helf: huper: {
      # Taken from cabal.project file in nix-tools repo
      hackage-db = helf.callPackage (huper.haskellSrc2nix rec {
        name = "hackage-db";
        src  = getSource { inherit name; };
      }) {};

      half = testsFail huper.half;

      # The nixpkgs version is marked as broken. The patch disables the repl
      # executable, since it fails to build (haskeline issue?) and we don't
      # need it.
      hnix = testsFail (helf.callPackage (huper.haskellSrc2nix rec {
        name = "hnix";
        src  = getSource { inherit name; };
      }) {});

      hnix-store-core = helf.callPackage (huper.haskellSrc2nix rec {
        name = "hnix-store-core";
        src  = getSource { inherit name; };
      }) {};

      # https://github.com/fosskers/microlens-aeson/issues/1
      microlens-aeson = testsFail huper.microlens-aeson;
    })
  ];
}).nix-tools
