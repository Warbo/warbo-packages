{
  pkgs = hackage: {
    packages = {
      "containers".revision =
        (((hackage."containers")."0.6.0.1").revisions).default;
      "base-compat".revision =
        (((hackage."base-compat")."0.11.0").revisions).default;
      "time-compat".revision =
        (((hackage."time-compat")."1.9.2.2").revisions).default;
      "time-compat".flags.old-locale = false;
      "tagged".revision = (((hackage."tagged")."0.8.6").revisions).default;
      "tagged".flags.transformers = true;
      "tagged".flags.deepseq = true;
      "blaze-builder".revision =
        (((hackage."blaze-builder")."0.4.1.0").revisions).default;
      "ansi-terminal".revision =
        (((hackage."ansi-terminal")."0.10.2").revisions).default;
      "ansi-terminal".flags.example = false;
      "bytestring".revision =
        (((hackage."bytestring")."0.10.8.2").revisions).default;
      "integer-logarithms".revision =
        (((hackage."integer-logarithms")."1.0.3").revisions).default;
      "integer-logarithms".flags.check-bounds = false;
      "integer-logarithms".flags.integer-gmp = true;
      "ansi-wl-pprint".revision =
        (((hackage."ansi-wl-pprint")."0.6.9").revisions).default;
      "ansi-wl-pprint".flags.example = false;
      "wcwidth".revision = (((hackage."wcwidth")."0.0.2").revisions).default;
      "wcwidth".flags.cli = false;
      "wcwidth".flags.split-base = true;
      "old-locale".revision =
        (((hackage."old-locale")."1.0.0.7").revisions).default;
      "unordered-containers".revision =
        (((hackage."unordered-containers")."0.2.10.0").revisions).default;
      "unordered-containers".flags.debug = false;
      "text".revision = (((hackage."text")."1.2.3.1").revisions).default;
      "base".revision = (((hackage."base")."4.12.0.0").revisions).default;
      "Cabal".revision = (((hackage."Cabal")."2.4.0.1").revisions).default;
      "time".revision = (((hackage."time")."1.8.0.2").revisions).default;
      "colour".revision = (((hackage."colour")."2.3.5").revisions).default;
      "attoparsec".revision =
        (((hackage."attoparsec")."0.13.2.3").revisions).default;
      "attoparsec".flags.developer = false;
      "transformers".revision =
        (((hackage."transformers")."0.5.6.2").revisions).default;
      "hashable".revision =
        (((hackage."hashable")."1.3.0.0").revisions).default;
      "hashable".flags.sse41 = false;
      "hashable".flags.examples = false;
      "hashable".flags.sse2 = true;
      "hashable".flags.integer-gmp = true;
      "filepath".revision =
        (((hackage."filepath")."1.4.2.1").revisions).default;
      "unbounded-delays".revision =
        (((hackage."unbounded-delays")."0.1.1.0").revisions).default;
      "process".revision = (((hackage."process")."1.6.5.0").revisions).default;
      "pretty".revision = (((hackage."pretty")."1.1.3.6").revisions).default;
      "aeson".revision = (((hackage."aeson")."1.4.6.0").revisions).default;
      "aeson".flags.cffi = false;
      "aeson".flags.fast = false;
      "aeson".flags.bytestring-builder = false;
      "aeson".flags.developer = false;
      "ghc-boot-th".revision =
        (((hackage."ghc-boot-th")."8.6.5").revisions).default;
      "array".revision = (((hackage."array")."0.5.3.0").revisions).default;
      "integer-gmp".revision =
        (((hackage."integer-gmp")."1.0.2.0").revisions).default;
      "th-abstraction".revision =
        (((hackage."th-abstraction")."0.3.1.0").revisions).default;
      "base-orphans".revision =
        (((hackage."base-orphans")."0.8.1").revisions).default;
      "binary".revision = (((hackage."binary")."0.8.6.0").revisions).default;
      "ghc-prim".revision = (((hackage."ghc-prim")."0.5.3").revisions).default;
      "stringable".revision =
        (((hackage."stringable")."0.1.3").revisions).default;
      "stm".revision = (((hackage."stm")."2.5.0.0").revisions).default;
      "unix".revision = (((hackage."unix")."2.7.2.2").revisions).default;
      "tasty-quickcheck".revision =
        (((hackage."tasty-quickcheck")."0.10.1").revisions).default;
      "atto-lisp".revision =
        (((hackage."atto-lisp")."0.2.2.3").revisions).default;
      "rts".revision = (((hackage."rts")."1.0").revisions).default;
      "mtl".revision = (((hackage."mtl")."2.2.2").revisions).default;
      "blaze-textual".revision =
        (((hackage."blaze-textual")."0.2.1.0").revisions).default;
      "blaze-textual".flags.integer-simple = false;
      "blaze-textual".flags.developer = false;
      "blaze-textual".flags.native = true;
      "clock".revision = (((hackage."clock")."0.8").revisions).default;
      "clock".flags.llvm = false;
      "tasty".revision = (((hackage."tasty")."1.2.3").revisions).default;
      "tasty".flags.clock = true;
      "scientific".revision =
        (((hackage."scientific")."0.3.6.2").revisions).default;
      "scientific".flags.integer-simple = false;
      "scientific".flags.bytestring-builder = false;
      "uuid-types".revision =
        (((hackage."uuid-types")."1.0.3").revisions).default;
      "random".revision = (((hackage."random")."1.1").revisions).default;
      "deepseq".revision = (((hackage."deepseq")."1.4.4.0").revisions).default;
      "QuickCheck".revision =
        (((hackage."QuickCheck")."2.13.2").revisions).default;
      "QuickCheck".flags.templatehaskell = true;
      "system-filepath".revision =
        (((hackage."system-filepath")."0.4.14").revisions).default;
      "optparse-applicative".revision =
        (((hackage."optparse-applicative")."0.15.1.0").revisions).default;
      "async".revision = (((hackage."async")."2.2.2").revisions).default;
      "async".flags.bench = false;
      "dlist".revision = (((hackage."dlist")."0.8.0.7").revisions).default;
      "splitmix".revision = (((hackage."splitmix")."0.0.3").revisions).default;
      "splitmix".flags.optimised-mixer = false;
      "splitmix".flags.random = true;
      "parsec".revision = (((hackage."parsec")."3.1.13.0").revisions).default;
      "vector".revision = (((hackage."vector")."0.12.0.3").revisions).default;
      "vector".flags.boundschecks = true;
      "vector".flags.unsafechecks = false;
      "vector".flags.internalchecks = false;
      "vector".flags.wall = false;
      "template-haskell".revision =
        (((hackage."template-haskell")."2.14.0.0").revisions).default;
      "directory".revision =
        (((hackage."directory")."1.3.3.0").revisions).default;
      "transformers-compat".revision =
        (((hackage."transformers-compat")."0.6.5").revisions).default;
      "transformers-compat".flags.two = false;
      "transformers-compat".flags.five-three = true;
      "transformers-compat".flags.mtl = true;
      "transformers-compat".flags.three = false;
      "transformers-compat".flags.four = false;
      "transformers-compat".flags.five = false;
      "transformers-compat".flags.generic-deriving = true;
      "primitive".revision =
        (((hackage."primitive")."0.7.0.0").revisions).default;
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
        "ghc-boot-th" = "8.6.5";
        "array" = "0.5.3.0";
        "integer-gmp" = "1.0.2.0";
        "binary" = "0.8.6.0";
        "ghc-prim" = "0.5.3";
        "stm" = "2.5.0.0";
        "unix" = "2.7.2.2";
        "rts" = "1.0";
        "mtl" = "2.2.2";
        "deepseq" = "1.4.4.0";
        "parsec" = "3.1.13.0";
        "template-haskell" = "2.14.0.0";
        "directory" = "1.3.3.0";
      };
    };
  };
  extras = hackage: { packages = { GetDeps = ./.plan.nix/GetDeps.nix; }; };
  modules =
    [ ({ lib, ... }: { packages = { "GetDeps" = { flags = { }; }; }; }) ];
}
