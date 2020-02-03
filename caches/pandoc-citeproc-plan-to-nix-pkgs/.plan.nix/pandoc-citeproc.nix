let
  buildDepError = pkg:
    builtins.throw ''
      The Haskell package set does not contain the package: ${pkg} (build dependency).
      
      If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.
      '';
  sysDepError = pkg:
    builtins.throw ''
      The Nixpkgs package set does not contain the package: ${pkg} (system dependency).
      
      You may need to augment the system package mapping in haskell.nix so that it can be found.
      '';
  pkgConfDepError = pkg:
    builtins.throw ''
      The pkg-conf packages does not contain the package: ${pkg} (pkg-conf dependency).
      
      You may need to augment the pkg-conf package mapping in haskell.nix so that it can be found.
      '';
  exeDepError = pkg:
    builtins.throw ''
      The local executable components do not include the component: ${pkg} (executable dependency).
      '';
  legacyExeDepError = pkg:
    builtins.throw ''
      The Haskell package set does not contain the package: ${pkg} (executable dependency).
      
      If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.
      '';
  buildToolDepError = pkg:
    builtins.throw ''
      Neither the Haskell package set or the Nixpkgs package set contain the package: ${pkg} (build tool dependency).
      
      If this is a system dependency:
      You may need to augment the system package mapping in haskell.nix so that it can be found.
      
      If this is a Haskell dependency:
      If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.
      '';
in { system, compiler, flags, pkgs, hsPkgs, pkgconfPkgs, ... }:
  {
    flags = {
      bibutils = true;
      embed_data_files = false;
      unicode_collation = false;
      test_citeproc = false;
      debug = false;
      static = false;
      };
    package = {
      specVersion = "1.12";
      identifier = { name = "pandoc-citeproc"; version = "0.16.4.1"; };
      license = "BSD-3-Clause";
      copyright = "";
      maintainer = "jgm@berkeley.edu";
      author = "John MacFarlane, Andrea Rossato";
      homepage = "https://github.com/jgm/pandoc-citeproc";
      url = "";
      synopsis = "Supports using pandoc with citeproc";
      description = "The pandoc-citeproc library supports automatic\ngeneration of citations and a bibliography in pandoc\ndocuments using the Citation Style Language (CSL)\nmacro language. More details on CSL can be found at\n<http://citationstyles.org/>.\n\nIn addition to a library, the package includes\nan executable, pandoc-citeproc, which works as a pandoc\nfilter and also has a mode for converting bibliographic\ndatabases into CSL JSON and pandoc YAML metadata formats.\n\npandoc-citeproc originated as a fork of Andrea\nRossato's citeproc-hs.";
      buildType = "Custom";
      isLocal = true;
      setup-depends = [
        (hsPkgs.buildPackages.base or (pkgs.buildPackages.base or (buildToolDepError "base")))
        (hsPkgs.buildPackages.Cabal or (pkgs.buildPackages.Cabal or (buildToolDepError "Cabal")))
        ];
      detailLevel = "FullDetails";
      licenseFiles = [ "LICENSE" ];
      dataDir = "";
      dataFiles = [
        "chicago-author-date.csl"
        "locales/*.xml"
        "README.md"
        "LICENSE"
        "man/man1/pandoc-citeproc.1"
        "changelog"
        ];
      extraSrcFiles = [
        "stack.yaml"
        "tests/*.in.native"
        "tests/*.expected.native"
        "tests/*.csl"
        "tests/biblio.bib"
        "tests/biblatex-examples.bib"
        "tests/biblio2yaml/*.bibtex"
        "tests/biblio2yaml/*.biblatex"
        "tests/biblio2yaml/pandoc-2/*.biblatex"
        ];
      extraTmpFiles = [];
      extraDocFiles = [];
      };
    components = {
      "library" = {
        depends = ((((([
          (hsPkgs."base" or (buildDepError "base"))
          (hsPkgs."syb" or (buildDepError "syb"))
          (hsPkgs."parsec" or (buildDepError "parsec"))
          (hsPkgs."old-locale" or (buildDepError "old-locale"))
          (hsPkgs."time" or (buildDepError "time"))
          (hsPkgs."containers" or (buildDepError "containers"))
          (hsPkgs."directory" or (buildDepError "directory"))
          (hsPkgs."mtl" or (buildDepError "mtl"))
          (hsPkgs."bytestring" or (buildDepError "bytestring"))
          (hsPkgs."filepath" or (buildDepError "filepath"))
          (hsPkgs."network" or (buildDepError "network"))
          (hsPkgs."pandoc-types" or (buildDepError "pandoc-types"))
          (hsPkgs."pandoc" or (buildDepError "pandoc"))
          (hsPkgs."tagsoup" or (buildDepError "tagsoup"))
          (hsPkgs."aeson" or (buildDepError "aeson"))
          (hsPkgs."text" or (buildDepError "text"))
          (hsPkgs."vector" or (buildDepError "vector"))
          (hsPkgs."xml-conduit" or (buildDepError "xml-conduit"))
          (hsPkgs."unordered-containers" or (buildDepError "unordered-containers"))
          (hsPkgs."data-default" or (buildDepError "data-default"))
          (hsPkgs."setenv" or (buildDepError "setenv"))
          (hsPkgs."split" or (buildDepError "split"))
          (hsPkgs."yaml" or (buildDepError "yaml"))
          (hsPkgs."HsYAML" or (buildDepError "HsYAML"))
          (hsPkgs."HsYAML-aeson" or (buildDepError "HsYAML-aeson"))
          ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.0") (hsPkgs."semigroups" or (buildDepError "semigroups"))) ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4") (hsPkgs."base-compat" or (buildDepError "base-compat"))) ++ (pkgs.lib).optional (flags.debug) (hsPkgs."pretty-show" or (buildDepError "pretty-show"))) ++ (pkgs.lib).optional (flags.bibutils) (hsPkgs."hs-bibutils" or (buildDepError "hs-bibutils"))) ++ (pkgs.lib).optional (flags.embed_data_files) (hsPkgs."file-embed" or (buildDepError "file-embed"))) ++ (if flags.unicode_collation
          then [
            (hsPkgs."text" or (buildDepError "text"))
            (hsPkgs."text-icu" or (buildDepError "text-icu"))
            ]
          else [ (hsPkgs."rfc5051" or (buildDepError "rfc5051")) ]);
        buildable = true;
        modules = ([
          "Text/CSL/Util"
          "Paths_pandoc_citeproc"
          "Text/CSL/Compat/Pandoc"
          "Text/CSL/Pandoc"
          "Text/CSL"
          "Text/CSL/Reference"
          "Text/CSL/Exception"
          "Text/CSL/Style"
          "Text/CSL/Eval"
          "Text/CSL/Eval/Common"
          "Text/CSL/Eval/Date"
          "Text/CSL/Eval/Names"
          "Text/CSL/Eval/Output"
          "Text/CSL/Parser"
          "Text/CSL/Proc"
          "Text/CSL/Proc/Collapse"
          "Text/CSL/Proc/Disamb"
          "Text/CSL/Input/Bibutils"
          "Text/CSL/Input/Bibtex"
          "Text/CSL/Output/Pandoc"
          "Text/CSL/Output/Plain"
          "Text/CSL/Data"
          ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4") "Prelude") ++ (pkgs.lib).optional (flags.embed_data_files) "Text/CSL/Data/Embedded";
        hsSourceDirs = [
          "src"
          "compat"
          ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4") "prelude";
        };
      exes = {
        "pandoc-citeproc" = {
          depends = ([
            (hsPkgs."base" or (buildDepError "base"))
            (hsPkgs."pandoc-citeproc" or (buildDepError "pandoc-citeproc"))
            (hsPkgs."pandoc-types" or (buildDepError "pandoc-types"))
            (hsPkgs."pandoc" or (buildDepError "pandoc"))
            (hsPkgs."aeson" or (buildDepError "aeson"))
            (hsPkgs."aeson-pretty" or (buildDepError "aeson-pretty"))
            (hsPkgs."yaml" or (buildDepError "yaml"))
            (hsPkgs."libyaml" or (buildDepError "libyaml"))
            (hsPkgs."bytestring" or (buildDepError "bytestring"))
            (hsPkgs."syb" or (buildDepError "syb"))
            (hsPkgs."attoparsec" or (buildDepError "attoparsec"))
            (hsPkgs."text" or (buildDepError "text"))
            (hsPkgs."filepath" or (buildDepError "filepath"))
            (hsPkgs."safe" or (buildDepError "safe"))
            ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.0") (hsPkgs."semigroups" or (buildDepError "semigroups"))) ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4") (hsPkgs."base-compat" or (buildDepError "base-compat"));
          buildable = true;
          modules = [
            "Paths_pandoc_citeproc"
            ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4") "Prelude";
          hsSourceDirs = [
            "."
            ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4") "prelude";
          mainPath = ((([
            "pandoc-citeproc.hs"
            ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.0") "") ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4") "") ++ (pkgs.lib).optional (flags.static) "") ++ (pkgs.lib).optional (flags.bibutils) "";
          };
        "test-citeproc" = {
          depends = ([
            (hsPkgs."base" or (buildDepError "base"))
            (hsPkgs."pandoc-citeproc" or (buildDepError "pandoc-citeproc"))
            (hsPkgs."aeson" or (buildDepError "aeson"))
            (hsPkgs."directory" or (buildDepError "directory"))
            (hsPkgs."text" or (buildDepError "text"))
            (hsPkgs."mtl" or (buildDepError "mtl"))
            (hsPkgs."pandoc-types" or (buildDepError "pandoc-types"))
            (hsPkgs."pandoc" or (buildDepError "pandoc"))
            (hsPkgs."filepath" or (buildDepError "filepath"))
            (hsPkgs."bytestring" or (buildDepError "bytestring"))
            (hsPkgs."process" or (buildDepError "process"))
            (hsPkgs."temporary" or (buildDepError "temporary"))
            (hsPkgs."yaml" or (buildDepError "yaml"))
            (hsPkgs."containers" or (buildDepError "containers"))
            (hsPkgs."vector" or (buildDepError "vector"))
            ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.0") (hsPkgs."semigroups" or (buildDepError "semigroups"))) ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4") (hsPkgs."base-compat" or (buildDepError "base-compat"));
          build-tools = [
            (hsPkgs.buildPackages.pandoc-citeproc or (pkgs.buildPackages.pandoc-citeproc or (buildToolDepError "pandoc-citeproc")))
            ];
          buildable = if flags.test_citeproc then true else false;
          modules = [
            "JSON"
            "Text/CSL/Compat/Pandoc"
            ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4") "Prelude";
          hsSourceDirs = [
            "tests"
            "compat"
            ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4") "prelude";
          mainPath = (([ "test-citeproc.hs" ] ++ [
            ""
            ]) ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.0") "") ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4") "";
          };
        };
      tests = {
        "test-pandoc-citeproc" = {
          depends = ([
            (hsPkgs."base" or (buildDepError "base"))
            (hsPkgs."aeson" or (buildDepError "aeson"))
            (hsPkgs."directory" or (buildDepError "directory"))
            (hsPkgs."text" or (buildDepError "text"))
            (hsPkgs."pandoc-types" or (buildDepError "pandoc-types"))
            (hsPkgs."mtl" or (buildDepError "mtl"))
            (hsPkgs."pandoc" or (buildDepError "pandoc"))
            (hsPkgs."filepath" or (buildDepError "filepath"))
            (hsPkgs."containers" or (buildDepError "containers"))
            (hsPkgs."bytestring" or (buildDepError "bytestring"))
            (hsPkgs."pandoc-citeproc" or (buildDepError "pandoc-citeproc"))
            (hsPkgs."process" or (buildDepError "process"))
            (hsPkgs."temporary" or (buildDepError "temporary"))
            (hsPkgs."yaml" or (buildDepError "yaml"))
            ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.0") (hsPkgs."semigroups" or (buildDepError "semigroups"))) ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4") (hsPkgs."base-compat" or (buildDepError "base-compat"));
          build-tools = [
            (hsPkgs.buildPackages.pandoc-citeproc or (pkgs.buildPackages.pandoc-citeproc or (buildToolDepError "pandoc-citeproc")))
            ];
          buildable = true;
          modules = [
            "JSON"
            "Text/CSL/Compat/Pandoc"
            ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4") "Prelude";
          hsSourceDirs = [
            "tests"
            "compat"
            ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4") "prelude";
          mainPath = [ "test-pandoc-citeproc.hs" ];
          };
        };
      };
    } // rec { src = (pkgs.lib).mkDefault ../.; }