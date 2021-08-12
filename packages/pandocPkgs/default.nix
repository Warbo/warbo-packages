# Fixed versions of pandoc, panpipe, panhandle, pandoc-citeproc
{ buildEnv, haskell-nix, lib, repo1909, panpipe, panhandle, stdenv }:

with rec {
  getHackage = args:
    with { pkgs = haskell-nix { repo = repo1909; }; };
    pkgs.haskell-nix.hackage-package ({
      index-state = "2020-01-11T00:00:00Z";
      ghc         = pkgs.buildPackages.pkgs.haskell-nix.compiler.ghc865;
    } // args);

  pandoc = getHackage {
    name    = "pandoc";
    version = "2.9.1";

    # Update these two when changing the derivation
    plan-sha256  = "036zb2pzwmihixm2r56aw6xyx69isx8hjdbqksnvgzma3yi86xy4";
    materialized = ../../caches/pandoc-plan-to-nix-pkgs;

    # Nix's restricted evaluation mode can't fetch arbitrary things from the
    # network, like the git repo specified in pandoc's cabal.project file.
    # To work around this, haskell.nix will spot comments specifying a sha256,
    # and use that to make a fixed-output derivation (which is allowed network
    # access). Since we can't change what's in pandoc's tarball, we can use
    # this argument to override it and include a sha256 comment.
    # TODO: This is a bit hacky, as it would be nicer to just specify the sha256
    # without having to duplicate the contents of pandoc's cabal.project.
    # https://github.com/input-output-hk/haskell.nix/issues/374
    cabalProject = ''
      packages: pandoc.cabal

      package pandoc
        flags: +embed_data_files -trypandoc
        ghc-options: -j +RTS -A64m -RTS

      package pandoc-citeproc
        flags: +embed_data_files +bibutils -unicode_collation -test_citeproc -debug
        ghc-options: -j +RTS -A64m -RTS

      source-repository-package
        type: git
        location: https://github.com/jgm/pandoc-citeproc
        tag: 0.16.4.1
        --sha256: 0z7cn1lz3gjllx69q7zqv9w9f16sdcsgps02d4qs43rcyf3pjcdh
    '';
  };

  pandoc-citeproc = getHackage {
    name    = "pandoc-citeproc";
    version = "0.16.4.1";

    # Update these when changing the derivation
    plan-sha256  = "08s7200sg21z426bshyg58n972srsczskvi7yy393q90rcr9cjz3";
    materialized = ../../caches/pandoc-citeproc-plan-to-nix-pkgs;
  };
};
if stdenv.isDarwin
   then null
   else buildEnv {
     name  = "pandocPkgs";
     paths = [
       pandoc.components.exes.pandoc
       pandoc-citeproc.components.exes.pandoc-citeproc
       panpipe
       panhandle
     ];
   }
