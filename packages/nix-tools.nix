{ fetchFromGitHub, haskell, haskellOverride, isBroken, nixpkgs1903, withDeps }:

with builtins;
with rec {
  inherit (haskell.lib) appendConfigureFlag dontCheck;
  hkgUrl    = nv: "https://hackage.haskell.org/package/${nv}/${nv}.tar.gz";
  testsFail = pkg: withDeps [(isBroken pkg)] (dontCheck pkg);
};
{
  pkg = (haskellOverride {
    inherit (nixpkgs1903) haskellPackages;
    extra = [
      (helf: huper: {
        # Taken from cabal.project file in nix-tools repo
        hackage-db = helf.callPackage (huper.haskellSrc2nix {
          name = "hackage-db";
          src  = fetchFromGitHub {
            owner  = "ElvishJerricco";
            repo   = "hackage-db";
            rev    = "84ca9fc";
            sha256 = "0y3kw1hrxhsqmyx59sxba8npj4ya8dpgjljc21gkgdvdy9628q4c";
          };
        }) {};

        half = testsFail huper.half;

        # The nixpkgs version is marked as broken. The patch disables the repl
        # executable, since it fails to build (haskeline issue?) and we don't
        # need it.
        hnix = testsFail (helf.callPackage (huper.haskellSrc2nix {
            name = "hnix";
            src  = fetchTarball {
              url    = hkgUrl "hnix-0.6.1";
              sha256 = "1kjga8pdwyb046hg7x1v5d5rvd9zccgzz1i656ydw44r4qxh1v0w";
            };
          }) {});

        hnix-store-core = helf.callPackage (huper.haskellSrc2nix {
          name = "hnix-store-core";
          src  = fetchTarball {
            url    = hkgUrl "hnix-store-core-0.1.0.0";
            sha256 = "0ibmqq9i0krjn8mw7h6c38ryyj11f8vyjqqvj72y36ashl9sdiyf";
          };
        }) {};

        # https://github.com/fosskers/microlens-aeson/issues/1
        microlens-aeson = testsFail huper.microlens-aeson;
      })
    ];
  }).nix-tools;

  tests = {};
}
