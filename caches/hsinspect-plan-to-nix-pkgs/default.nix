{
  pkgs = hackage:
    {
      packages = {
        "containers".revision = (((hackage."containers")."0.6.0.1").revisions).default;
        "bytestring".revision = (((hackage."bytestring")."0.10.8.2").revisions).default;
        "contravariant".revision = (((hackage."contravariant")."1.5.2").revisions).default;
        "contravariant".flags.tagged = false;
        "contravariant".flags.statevar = false;
        "contravariant".flags.semigroups = false;
        "base".revision = (((hackage."base")."4.12.0.0").revisions).default;
        "time".revision = (((hackage."time")."1.8.0.2").revisions).default;
        "transformers".revision = (((hackage."transformers")."0.5.6.2").revisions).default;
        "terminfo".revision = (((hackage."terminfo")."0.4.1.2").revisions).default;
        "filepath".revision = (((hackage."filepath")."1.4.2.1").revisions).default;
        "hpc".revision = (((hackage."hpc")."0.6.0.3").revisions).default;
        "process".revision = (((hackage."process")."1.6.5.0").revisions).default;
        "pretty".revision = (((hackage."pretty")."1.1.3.6").revisions).default;
        "ghc-boot-th".revision = (((hackage."ghc-boot-th")."8.6.5").revisions).default;
        "array".revision = (((hackage."array")."0.5.3.0").revisions).default;
        "integer-gmp".revision = (((hackage."integer-gmp")."1.0.2.0").revisions).default;
        "ghc".revision = (((hackage."ghc")."8.6.5").revisions).default;
        "binary".revision = (((hackage."binary")."0.8.6.0").revisions).default;
        "ghc-prim".revision = (((hackage."ghc-prim")."0.5.3").revisions).default;
        "ghc-boot".revision = (((hackage."ghc-boot")."8.6.5").revisions).default;
        "unix".revision = (((hackage."unix")."2.7.2.2").revisions).default;
        "ghci".revision = (((hackage."ghci")."8.6.5").revisions).default;
        "rts".revision = (((hackage."rts")."1.0").revisions).default;
        "ghc-heap".revision = (((hackage."ghc-heap")."8.6.5").revisions).default;
        "deepseq".revision = (((hackage."deepseq")."1.4.4.0").revisions).default;
        "template-haskell".revision = (((hackage."template-haskell")."2.14.0.0").revisions).default;
        "directory".revision = (((hackage."directory")."1.3.3.0").revisions).default;
        };
      compiler = {
        version = "8.6.5";
        nix-name = "ghc865";
        packages = {
          "containers" = "0.6.0.1";
          "bytestring" = "0.10.8.2";
          "base" = "4.12.0.0";
          "time" = "1.8.0.2";
          "transformers" = "0.5.6.2";
          "terminfo" = "0.4.1.2";
          "filepath" = "1.4.2.1";
          "hpc" = "0.6.0.3";
          "process" = "1.6.5.0";
          "pretty" = "1.1.3.6";
          "ghc-boot-th" = "8.6.5";
          "array" = "0.5.3.0";
          "integer-gmp" = "1.0.2.0";
          "ghc" = "8.6.5";
          "binary" = "0.8.6.0";
          "ghc-prim" = "0.5.3";
          "ghc-boot" = "8.6.5";
          "unix" = "2.7.2.2";
          "ghci" = "8.6.5";
          "rts" = "1.0";
          "ghc-heap" = "8.6.5";
          "deepseq" = "1.4.4.0";
          "template-haskell" = "2.14.0.0";
          "directory" = "1.3.3.0";
          };
        };
      };
  extras = hackage:
    {
      packages = {
        medley = ./.plan.nix/medley.nix;
        hsinspect = ./.plan.nix/hsinspect.nix;
        ghcflags = ./.plan.nix/ghcflags.nix;
        };
      };
  modules = [
    ({ lib, ... }:
      {
        packages = {
          "medley" = {
            flags = {
              "uncompilable" = lib.mkOverride 900 true;
              "ghcflags" = lib.mkOverride 900 true;
              };
            };
          "hsinspect" = { flags = { "ghcflags" = lib.mkOverride 900 true; }; };
          "ghcflags" = { flags = {}; };
          };
        })
    ];
  }