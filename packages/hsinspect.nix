{ fetchFromGitLab, haskell-nix, repo1909 }:

with rec {
  pkgs  = haskell-nix { repo = repo1909; };

  nixed = pkgs.haskell-nix.cabalProject {
    ghc         = pkgs.buildPackages.pkgs.haskell-nix.compiler.ghc865;
    index-state = "2020-01-11T00:00:00Z";
    src         = fetchFromGitLab {
      owner  = "tseenshe";
      repo   = "hsinspect";
      rev    = "406cabe6";
      sha256 = "0gc5y60bmshrwl1mhrlzzq6jk1pfj82q5qgzvxiwk70qhpjm7x1v";
    };

    # Avoid 'Neither the Haskell package set or the Nixpkgs package set contain
    # the package: alex (build tool dependency).'
    # The issue AFAIK seems to be that "bootstrap" packages (used by GHC) can
    # either be fixed, to avoid excessive rebuilding; or reinstallable, to allow
    # overrides, etc. There are some packages which are the wrong way around
    # somewhere in the dependencies of hsinspect, so we specify them explicitly
    # here. Found this via trial and error, thanks to
    # https://github.com/input-output-hk/haskell.nix/issues/221
    modules = [
      { reinstallableLibGhc = true; }
      {
        nonReinstallablePkgs = [
          "array"
          "array"
          "base"
          "binary"
          "bytestring"
          "Cabal"
          "containers"
          "deepseq"
          "directory"
          "filepath"
          "ghc"
          "ghc-boot"
          "ghc-boot"
          "ghc-boot-th"
          "ghc-compact"
          "ghc-heap"
          "ghc-prim"
          "ghc-prim"
          "ghci"
          "ghcjs-prim"
          "ghcjs-th"
          "haskeline"
          "hpc"
          "integer-gmp"
          "integer-simple"
          "mtl"
          "parsec"
          "pretty"
          "process"
          "rts"
          "stm"
          "template-haskell"
          "terminfo"
          "text"
          "time"
          "transformers"
          "unix"
          "Win32"
          "xhtml"
        ];
      }
    ];
  };

  inherit (nixed.hsinspect) components;
};
{
  inherit (components) tests;
  pkg = components.exes.hsinspect;
}
