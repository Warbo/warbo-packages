{
  pkgs = hackage: {
    packages = {
      "jira-wiki-markup".revision =
        (((hackage."jira-wiki-markup")."1.0.0").revisions).default;
      "hslua-module-text".revision =
        (((hackage."hslua-module-text")."0.2.1").revisions).default;
      "hxt".revision = (((hackage."hxt")."9.3.1.18").revisions).default;
      "hxt".flags.network-uri = false;
      "hxt".flags.profile = false;
      "x509-system".revision =
        (((hackage."x509-system")."1.6.6").revisions).default;
      "unliftio-core".revision =
        (((hackage."unliftio-core")."0.1.2.0").revisions).default;
      "hslua-module-system".revision =
        (((hackage."hslua-module-system")."0.2.1").revisions).default;
      "containers".revision =
        (((hackage."containers")."0.6.0.1").revisions).default;
      "x509".revision = (((hackage."x509")."1.7.5").revisions).default;
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
      "setenv".revision = (((hackage."setenv")."0.1.1.3").revisions).default;
      "streaming-commons".revision =
        (((hackage."streaming-commons")."0.2.1.2").revisions).default;
      "streaming-commons".flags.use-bytestring-builder = false;
      "bytestring".revision =
        (((hackage."bytestring")."0.10.8.2").revisions).default;
      "integer-logarithms".revision =
        (((hackage."integer-logarithms")."1.0.3").revisions).default;
      "integer-logarithms".flags.check-bounds = false;
      "integer-logarithms".flags.integer-gmp = true;
      "cmark-gfm".revision =
        (((hackage."cmark-gfm")."0.2.1").revisions).default;
      "cmark-gfm".flags.pkgconfig = false;
      "basement".revision = (((hackage."basement")."0.0.11").revisions).default;
      "JuicyPixels".revision =
        (((hackage."JuicyPixels")."3.3.4").revisions).default;
      "JuicyPixels".flags.mmap = false;
      "socks".revision = (((hackage."socks")."0.6.1").revisions).default;
      "mime-types".revision =
        (((hackage."mime-types")."0.1.0.9").revisions).default;
      "data-default-instances-dlist".revision =
        (((hackage."data-default-instances-dlist")."0.0.1").revisions).default;
      "old-locale".revision =
        (((hackage."old-locale")."1.0.0.7").revisions).default;
      "http-client-tls".revision =
        (((hackage."http-client-tls")."0.3.5.3").revisions).default;
      "HsYAML".revision = (((hackage."HsYAML")."0.2.1.0").revisions).default;
      "HsYAML".flags.exe = false;
      "typed-process".revision =
        (((hackage."typed-process")."0.2.6.0").revisions).default;
      "unordered-containers".revision =
        (((hackage."unordered-containers")."0.2.10.0").revisions).default;
      "unordered-containers".flags.debug = false;
      "blaze-markup".revision =
        (((hackage."blaze-markup")."0.8.2.3").revisions).default;
      "text".revision = (((hackage."text")."1.2.3.1").revisions).default;
      "data-default-class".revision =
        (((hackage."data-default-class")."0.1.2.0").revisions).default;
      "base64-bytestring".revision =
        (((hackage."base64-bytestring")."1.0.0.2").revisions).default;
      "aeson-pretty".revision =
        (((hackage."aeson-pretty")."0.8.8").revisions).default;
      "aeson-pretty".flags.lib-only = false;
      "base".revision = (((hackage."base")."4.12.0.0").revisions).default;
      "unicode-transforms".revision =
        (((hackage."unicode-transforms")."0.3.6").revisions).default;
      "unicode-transforms".flags.has-llvm = false;
      "unicode-transforms".flags.dev = false;
      "unicode-transforms".flags.bench-show = false;
      "unicode-transforms".flags.has-icu = false;
      "Cabal".revision = (((hackage."Cabal")."2.4.0.1").revisions).default;
      "time".revision = (((hackage."time")."1.8.0.2").revisions).default;
      "blaze-html".revision =
        (((hackage."blaze-html")."0.9.1.2").revisions).default;
      "colour".revision = (((hackage."colour")."2.3.5").revisions).default;
      "digest".revision = (((hackage."digest")."0.0.1.2").revisions).default;
      "digest".flags.bytestring-in-base = false;
      "attoparsec".revision =
        (((hackage."attoparsec")."0.13.2.3").revisions).default;
      "attoparsec".flags.developer = false;
      "base16-bytestring".revision =
        (((hackage."base16-bytestring")."0.1.1.6").revisions).default;
      "hxt-charproperties".revision =
        (((hackage."hxt-charproperties")."9.4.0.0").revisions).default;
      "hxt-charproperties".flags.profile = false;
      "transformers".revision =
        (((hackage."transformers")."0.5.6.2").revisions).default;
      "data-default-instances-containers".revision =
        (((hackage."data-default-instances-containers")."0.0.1").revisions).default;
      "vector-algorithms".revision =
        (((hackage."vector-algorithms")."0.8.0.3").revisions).default;
      "vector-algorithms".flags.boundschecks = true;
      "vector-algorithms".flags.bench = true;
      "vector-algorithms".flags.properties = true;
      "vector-algorithms".flags.unsafechecks = false;
      "vector-algorithms".flags.internalchecks = false;
      "vector-algorithms".flags.llvm = false;
      "hashable".revision =
        (((hackage."hashable")."1.3.0.0").revisions).default;
      "hashable".flags.sse41 = false;
      "hashable".flags.examples = false;
      "hashable".flags.sse2 = true;
      "hashable".flags.integer-gmp = true;
      "regex-pcre-builtin".revision =
        (((hackage."regex-pcre-builtin")."0.95.1.1.8.43").revisions).default;
      "HTTP".revision = (((hackage."HTTP")."4000.3.14").revisions).default;
      "HTTP".flags.warp-tests = false;
      "HTTP".flags.network-uri = true;
      "HTTP".flags.mtl1 = false;
      "HTTP".flags.conduit10 = false;
      "HTTP".flags.warn-as-error = false;
      "filepath".revision =
        (((hackage."filepath")."1.4.2.1").revisions).default;
      "doctemplates".revision =
        (((hackage."doctemplates")."0.8").revisions).default;
      "tls".revision = (((hackage."tls")."1.5.3").revisions).default;
      "tls".flags.hans = false;
      "tls".flags.compat = true;
      "tls".flags.network = true;
      "asn1-types".revision =
        (((hackage."asn1-types")."0.3.3").revisions).default;
      "process".revision = (((hackage."process")."1.6.5.0").revisions).default;
      "http-types".revision =
        (((hackage."http-types")."0.12.3").revisions).default;
      "resourcet".revision =
        (((hackage."resourcet")."1.2.2").revisions).default;
      "Glob".revision = (((hackage."Glob")."0.10.0").revisions).default;
      "libyaml".revision = (((hackage."libyaml")."0.1.1.1").revisions).default;
      "libyaml".flags.no-unicode = false;
      "libyaml".flags.system-libyaml = false;
      "pretty".revision = (((hackage."pretty")."1.1.3.6").revisions).default;
      "rfc5051".revision = (((hackage."rfc5051")."0.1.0.4").revisions).default;
      "rfc5051".flags.mkunicodedata = false;
      "hxt-unicode".revision =
        (((hackage."hxt-unicode")."9.0.2.4").revisions).default;
      "aeson".revision = (((hackage."aeson")."1.4.6.0").revisions).default;
      "aeson".flags.cffi = false;
      "aeson".flags.fast = false;
      "aeson".flags.bytestring-builder = false;
      "aeson".flags.developer = false;
      "ghc-boot-th".revision =
        (((hackage."ghc-boot-th")."8.6.5").revisions).default;
      "conduit-extra".revision =
        (((hackage."conduit-extra")."1.3.4").revisions).default;
      "array".revision = (((hackage."array")."0.5.3.0").revisions).default;
      "HsYAML-aeson".revision =
        (((hackage."HsYAML-aeson")."0.2.0.0").revisions).default;
      "integer-gmp".revision =
        (((hackage."integer-gmp")."1.0.2.0").revisions).default;
      "memory".revision = (((hackage."memory")."0.15.0").revisions).default;
      "memory".flags.support_deepseq = true;
      "memory".flags.support_bytestring = true;
      "memory".flags.support_basement = true;
      "memory".flags.support_foundation = true;
      "pandoc-types".revision =
        (((hackage."pandoc-types")."1.20").revisions).default;
      "xml".revision = (((hackage."xml")."1.3.14").revisions).default;
      "th-abstraction".revision =
        (((hackage."th-abstraction")."0.3.1.0").revisions).default;
      "base-orphans".revision =
        (((hackage."base-orphans")."0.8.1").revisions).default;
      "http-client".revision =
        (((hackage."http-client")."0.6.4").revisions).default;
      "http-client".flags.network-uri = true;
      "ipynb".revision = (((hackage."ipynb")."0.1").revisions).default;
      "cereal".revision = (((hackage."cereal")."0.5.8.1").revisions).default;
      "cereal".flags.bytestring-builder = false;
      "exceptions".revision =
        (((hackage."exceptions")."0.10.4").revisions).default;
      "exceptions".flags.transformers-0-4 = true;
      "cookie".revision = (((hackage."cookie")."0.4.5").revisions).default;
      "zip-archive".revision =
        (((hackage."zip-archive")."0.4.1").revisions).default;
      "zip-archive".flags.executable = false;
      "haddock-library".revision =
        (((hackage."haddock-library")."1.8.0").revisions).default;
      "emojis".revision = (((hackage."emojis")."0.1").revisions).default;
      "binary".revision = (((hackage."binary")."0.8.6.0").revisions).default;
      "ghc-prim".revision = (((hackage."ghc-prim")."0.5.3").revisions).default;
      "utf8-string".revision =
        (((hackage."utf8-string")."1.0.1.1").revisions).default;
      "pandoc".revision = (((hackage."pandoc")."2.9.1.1").revisions).default;
      "pandoc".flags.static = false;
      "pandoc".flags.trypandoc = false;
      "pandoc".flags.embed_data_files = false;
      "xml-types".revision =
        (((hackage."xml-types")."0.3.6").revisions).default;
      "skylighting".revision =
        (((hackage."skylighting")."0.8.3").revisions).default;
      "skylighting".flags.executable = false;
      "stm".revision = (((hackage."stm")."2.5.0.0").revisions).default;
      "case-insensitive".revision =
        (((hackage."case-insensitive")."1.2.1.0").revisions).default;
      "unix".revision = (((hackage."unix")."2.7.2.2").revisions).default;
      "fail".revision = (((hackage."fail")."4.9.0.0").revisions).default;
      "xml-conduit".revision =
        (((hackage."xml-conduit")."1.8.0.1").revisions).default;
      "SHA".revision = (((hackage."SHA")."1.6.4.4").revisions).default;
      "SHA".flags.exe = false;
      "x509-validation".revision =
        (((hackage."x509-validation")."1.6.11").revisions).default;
      "split".revision = (((hackage."split")."0.2.3.3").revisions).default;
      "hourglass".revision =
        (((hackage."hourglass")."0.2.12").revisions).default;
      "doclayout".revision =
        (((hackage."doclayout")."0.2.0.1").revisions).default;
      "regex-base".revision =
        (((hackage."regex-base")."0.94.0.0").revisions).default;
      "cmdargs".revision = (((hackage."cmdargs")."0.10.20").revisions).default;
      "cmdargs".flags.quotation = true;
      "cmdargs".flags.testprog = false;
      "cryptonite".revision =
        (((hackage."cryptonite")."0.26").revisions).default;
      "cryptonite".flags.support_rdrand = true;
      "cryptonite".flags.support_aesni = true;
      "cryptonite".flags.support_deepseq = true;
      "cryptonite".flags.check_alignment = false;
      "cryptonite".flags.support_pclmuldq = false;
      "cryptonite".flags.old_toolchain_inliner = false;
      "cryptonite".flags.support_sse = false;
      "cryptonite".flags.integer-gmp = true;
      "asn1-parse".revision =
        (((hackage."asn1-parse")."0.9.5").revisions).default;
      "zlib".revision = (((hackage."zlib")."0.6.2.1").revisions).default;
      "zlib".flags.pkg-config = false;
      "zlib".flags.non-blocking-ffi = false;
      "rts".revision = (((hackage."rts")."1.0").revisions).default;
      "network-uri".revision =
        (((hackage."network-uri")."2.6.1.0").revisions).default;
      "mtl".revision = (((hackage."mtl")."2.2.2").revisions).default;
      "syb".revision = (((hackage."syb")."0.7.1").revisions).default;
      "hs-bibutils".revision =
        (((hackage."hs-bibutils")."6.8.0.0").revisions).default;
      "pem".revision = (((hackage."pem")."0.2.4").revisions).default;
      "errors".revision = (((hackage."errors")."2.3.0").revisions).default;
      "tagsoup".revision = (((hackage."tagsoup")."0.14.8").revisions).default;
      "scientific".revision =
        (((hackage."scientific")."0.3.6.2").revisions).default;
      "scientific".flags.integer-simple = false;
      "scientific".flags.bytestring-builder = false;
      "temporary".revision = (((hackage."temporary")."1.3").revisions).default;
      "uuid-types".revision =
        (((hackage."uuid-types")."1.0.3").revisions).default;
      "asn1-encoding".revision =
        (((hackage."asn1-encoding")."0.9.6").revisions).default;
      "random".revision = (((hackage."random")."1.1").revisions).default;
      "deepseq".revision = (((hackage."deepseq")."1.4.4.0").revisions).default;
      "text-conversions".revision =
        (((hackage."text-conversions")."0.3.0").revisions).default;
      "QuickCheck".revision =
        (((hackage."QuickCheck")."2.13.2").revisions).default;
      "QuickCheck".flags.templatehaskell = true;
      "hslua".revision = (((hackage."hslua")."1.0.3.2").revisions).default;
      "hslua".flags.export-dynamic = true;
      "hslua".flags.allow-unsafe-gc = true;
      "hslua".flags.system-lua = false;
      "hslua".flags.pkg-config = false;
      "hslua".flags.hardcode-reg-keys = false;
      "hslua".flags.apicheck = false;
      "hslua".flags.lua_32bits = false;
      "async".revision = (((hackage."async")."2.2.2").revisions).default;
      "async".flags.bench = false;
      "dlist".revision = (((hackage."dlist")."0.8.0.7").revisions).default;
      "splitmix".revision = (((hackage."splitmix")."0.0.3").revisions).default;
      "splitmix".flags.optimised-mixer = false;
      "splitmix".flags.random = true;
      "data-default".revision =
        (((hackage."data-default")."0.7.1.1").revisions).default;
      "x509-store".revision =
        (((hackage."x509-store")."1.6.7").revisions).default;
      "network".revision = (((hackage."network")."3.1.1.1").revisions).default;
      "connection".revision =
        (((hackage."connection")."0.3.1").revisions).default;
      "data-default-instances-old-locale".revision =
        (((hackage."data-default-instances-old-locale")."0.0.1").revisions).default;
      "parsec".revision = (((hackage."parsec")."3.1.13.0").revisions).default;
      "bitarray".revision =
        (((hackage."bitarray")."0.0.1.1").revisions).default;
      "conduit".revision = (((hackage."conduit")."1.3.1.2").revisions).default;
      "safe".revision = (((hackage."safe")."0.3.18").revisions).default;
      "hxt-regex-xmlschema".revision =
        (((hackage."hxt-regex-xmlschema")."9.2.0.3").revisions).default;
      "hxt-regex-xmlschema".flags.profile = false;
      "mono-traversable".revision =
        (((hackage."mono-traversable")."1.0.15.1").revisions).default;
      "vector".revision = (((hackage."vector")."0.12.0.3").revisions).default;
      "vector".flags.boundschecks = true;
      "vector".flags.unsafechecks = false;
      "vector".flags.internalchecks = false;
      "vector".flags.wall = false;
      "hsc2hs".revision = (((hackage."hsc2hs")."0.68.6").revisions).default;
      "hsc2hs".flags.in-ghc-tree = false;
      "template-haskell".revision =
        (((hackage."template-haskell")."2.14.0.0").revisions).default;
      "yaml".revision = (((hackage."yaml")."0.11.2.0").revisions).default;
      "yaml".flags.no-exe = true;
      "yaml".flags.no-examples = true;
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
      "texmath".revision = (((hackage."texmath")."0.12").revisions).default;
      "texmath".flags.network-uri = true;
      "texmath".flags.executable = false;
      "skylighting-core".revision =
        (((hackage."skylighting-core")."0.8.3").revisions).default;
      "skylighting-core".flags.system-pcre = false;
      "skylighting-core".flags.executable = false;
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
  extras = hackage: {
    packages = { pandoc-citeproc = ./.plan.nix/pandoc-citeproc.nix; };
  };
  modules = [
    ({ lib, ... }: {
      packages = {
        "pandoc-citeproc" = {
          flags = {
            "test_citeproc" = lib.mkOverride 900 false;
            "static" = lib.mkOverride 900 false;
            "bibutils" = lib.mkOverride 900 true;
            "embed_data_files" = lib.mkOverride 900 false;
            "unicode_collation" = lib.mkOverride 900 false;
            "debug" = lib.mkOverride 900 false;
          };
        };
      };
    })
  ];
}
