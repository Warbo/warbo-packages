{
  pkgs = hackage:
    {
      packages = {
        "containers".revision = (((hackage."containers")."0.6.0.1").revisions).default;
        "ansi-terminal".revision = (((hackage."ansi-terminal")."0.10.2").revisions).default;
        "ansi-terminal".flags.example = false;
        "bytestring".revision = (((hackage."bytestring")."0.10.8.2").revisions).default;
        "integer-logarithms".revision = (((hackage."integer-logarithms")."1.0.3").revisions).default;
        "integer-logarithms".flags.check-bounds = false;
        "integer-logarithms".flags.integer-gmp = true;
        "ansi-wl-pprint".revision = (((hackage."ansi-wl-pprint")."0.6.9").revisions).default;
        "ansi-wl-pprint".flags.example = false;
        "haskell-lexer".revision = (((hackage."haskell-lexer")."1.0.2").revisions).default;
        "text".revision = (((hackage."text")."1.2.3.1").revisions).default;
        "Diff".revision = (((hackage."Diff")."0.3.4").revisions).default;
        "base".revision = (((hackage."base")."4.12.0.0").revisions).default;
        "Cabal".revision = (((hackage."Cabal")."2.4.0.1").revisions).default;
        "time".revision = (((hackage."time")."1.8.0.2").revisions).default;
        "colour".revision = (((hackage."colour")."2.3.5").revisions).default;
        "attoparsec".revision = (((hackage."attoparsec")."0.13.2.3").revisions).default;
        "attoparsec".flags.developer = false;
        "happy".revision = (((hackage."happy")."1.19.12").revisions).default;
        "happy".flags.small_base = true;
        "transformers".revision = (((hackage."transformers")."0.5.6.2").revisions).default;
        "hashable".revision = (((hackage."hashable")."1.3.0.0").revisions).default;
        "hashable".flags.sse41 = false;
        "hashable".flags.examples = false;
        "hashable".flags.sse2 = true;
        "hashable".flags.integer-gmp = true;
        "pretty-show".revision = (((hackage."pretty-show")."1.9.5").revisions).default;
        "filepath".revision = (((hackage."filepath")."1.4.2.1").revisions).default;
        "nix-derivation".revision = (((hackage."nix-derivation")."1.0.2").revisions).default;
        "process".revision = (((hackage."process")."1.6.5.0").revisions).default;
        "pretty".revision = (((hackage."pretty")."1.1.3.6").revisions).default;
        "array".revision = (((hackage."array")."0.5.3.0").revisions).default;
        "integer-gmp".revision = (((hackage."integer-gmp")."1.0.2.0").revisions).default;
        "binary".revision = (((hackage."binary")."0.8.6.0").revisions).default;
        "ghc-prim".revision = (((hackage."ghc-prim")."0.5.3").revisions).default;
        "unix".revision = (((hackage."unix")."2.7.2.2").revisions).default;
        "rts".revision = (((hackage."rts")."1.0").revisions).default;
        "mtl".revision = (((hackage."mtl")."2.2.2").revisions).default;
        "scientific".revision = (((hackage."scientific")."0.3.6.2").revisions).default;
        "scientific".flags.integer-simple = false;
        "scientific".flags.bytestring-builder = false;
        "deepseq".revision = (((hackage."deepseq")."1.4.4.0").revisions).default;
        "system-filepath".revision = (((hackage."system-filepath")."0.4.14").revisions).default;
        "optparse-applicative".revision = (((hackage."optparse-applicative")."0.14.3.0").revisions).default;
        "parsec".revision = (((hackage."parsec")."3.1.13.0").revisions).default;
        "vector".revision = (((hackage."vector")."0.12.0.3").revisions).default;
        "vector".flags.boundschecks = true;
        "vector".flags.unsafechecks = false;
        "vector".flags.internalchecks = false;
        "vector".flags.wall = false;
        "directory".revision = (((hackage."directory")."1.3.3.0").revisions).default;
        "transformers-compat".revision = (((hackage."transformers-compat")."0.6.5").revisions).default;
        "transformers-compat".flags.two = false;
        "transformers-compat".flags.five-three = true;
        "transformers-compat".flags.mtl = true;
        "transformers-compat".flags.three = false;
        "transformers-compat".flags.four = false;
        "transformers-compat".flags.five = false;
        "transformers-compat".flags.generic-deriving = true;
        "primitive".revision = (((hackage."primitive")."0.7.0.0").revisions).default;
        };
      compiler = {
        version = "8.6.5";
        nix-name = "ghc865";
        packages = {
          "containers" = "0.6.0.1";
          "bytestring" = "0.10.8.2";
          "text" = "1.2.3.1";
          "base" = "4.12.0.0";
          "Cabal" = "2.4.0.1";
          "time" = "1.8.0.2";
          "transformers" = "0.5.6.2";
          "filepath" = "1.4.2.1";
          "process" = "1.6.5.0";
          "pretty" = "1.1.3.6";
          "array" = "0.5.3.0";
          "integer-gmp" = "1.0.2.0";
          "binary" = "0.8.6.0";
          "ghc-prim" = "0.5.3";
          "unix" = "2.7.2.2";
          "rts" = "1.0";
          "mtl" = "2.2.2";
          "deepseq" = "1.4.4.0";
          "parsec" = "3.1.13.0";
          "directory" = "1.3.3.0";
          };
        };
      };
  extras = hackage:
    { packages = { nix-diff = ./.plan.nix/nix-diff.nix; }; };
  modules = [
    ({ lib, ... }:
      { packages = { "nix-diff" = { flags = {}; }; }; })
    ];
  }