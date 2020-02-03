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
    flags = {};
    package = {
      specVersion = "1.8";
      identifier = { name = "ShellCheck"; version = "0.7.0"; };
      license = "GPL-3.0-only";
      copyright = "";
      maintainer = "vidar@vidarholen.net";
      author = "Vidar Holen";
      homepage = "https://www.shellcheck.net/";
      url = "";
      synopsis = "Shell script analysis tool";
      description = "The goals of ShellCheck are:\n\n* To point out and clarify typical beginner's syntax issues,\nthat causes a shell to give cryptic error messages.\n\n* To point out and clarify typical intermediate level semantic problems,\nthat causes a shell to behave strangely and counter-intuitively.\n\n* To point out subtle caveats, corner cases and pitfalls, that may cause an\nadvanced user's otherwise working script to fail under future circumstances.";
      buildType = "Custom";
      isLocal = true;
      setup-depends = [
        (hsPkgs.buildPackages.base or (pkgs.buildPackages.base or (buildToolDepError "base")))
        (hsPkgs.buildPackages.process or (pkgs.buildPackages.process or (buildToolDepError "process")))
        (hsPkgs.buildPackages.Cabal or (pkgs.buildPackages.Cabal or (buildToolDepError "Cabal")))
        ];
      detailLevel = "FullDetails";
      licenseFiles = [ "LICENSE" ];
      dataDir = "";
      dataFiles = [];
      extraSrcFiles = [
        "README.md"
        "shellcheck.1.md"
        "shellcheck.1"
        "striptests"
        "test/shellcheck.hs"
        ];
      extraTmpFiles = [];
      extraDocFiles = [];
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs."aeson" or (buildDepError "aeson"))
          (hsPkgs."array" or (buildDepError "array"))
          (hsPkgs."base" or (buildDepError "base"))
          (hsPkgs."bytestring" or (buildDepError "bytestring"))
          (hsPkgs."containers" or (buildDepError "containers"))
          (hsPkgs."deepseq" or (buildDepError "deepseq"))
          (hsPkgs."Diff" or (buildDepError "Diff"))
          (hsPkgs."directory" or (buildDepError "directory"))
          (hsPkgs."mtl" or (buildDepError "mtl"))
          (hsPkgs."filepath" or (buildDepError "filepath"))
          (hsPkgs."parsec" or (buildDepError "parsec"))
          (hsPkgs."regex-tdfa" or (buildDepError "regex-tdfa"))
          (hsPkgs."QuickCheck" or (buildDepError "QuickCheck"))
          (hsPkgs."process" or (buildDepError "process"))
          ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.0") (hsPkgs."semigroups" or (buildDepError "semigroups"));
        buildable = true;
        modules = [
          "Paths_ShellCheck"
          "ShellCheck/AST"
          "ShellCheck/ASTLib"
          "ShellCheck/Analytics"
          "ShellCheck/Analyzer"
          "ShellCheck/AnalyzerLib"
          "ShellCheck/Checker"
          "ShellCheck/Checks/Commands"
          "ShellCheck/Checks/Custom"
          "ShellCheck/Checks/ShellSupport"
          "ShellCheck/Data"
          "ShellCheck/Fixer"
          "ShellCheck/Formatter/Format"
          "ShellCheck/Formatter/CheckStyle"
          "ShellCheck/Formatter/Diff"
          "ShellCheck/Formatter/GCC"
          "ShellCheck/Formatter/JSON"
          "ShellCheck/Formatter/JSON1"
          "ShellCheck/Formatter/TTY"
          "ShellCheck/Formatter/Quiet"
          "ShellCheck/Interface"
          "ShellCheck/Parser"
          "ShellCheck/Regex"
          ];
        hsSourceDirs = [ "src" ];
        };
      exes = {
        "shellcheck" = {
          depends = [
            (hsPkgs."aeson" or (buildDepError "aeson"))
            (hsPkgs."array" or (buildDepError "array"))
            (hsPkgs."base" or (buildDepError "base"))
            (hsPkgs."bytestring" or (buildDepError "bytestring"))
            (hsPkgs."containers" or (buildDepError "containers"))
            (hsPkgs."deepseq" or (buildDepError "deepseq"))
            (hsPkgs."Diff" or (buildDepError "Diff"))
            (hsPkgs."directory" or (buildDepError "directory"))
            (hsPkgs."mtl" or (buildDepError "mtl"))
            (hsPkgs."filepath" or (buildDepError "filepath"))
            (hsPkgs."parsec" or (buildDepError "parsec"))
            (hsPkgs."QuickCheck" or (buildDepError "QuickCheck"))
            (hsPkgs."regex-tdfa" or (buildDepError "regex-tdfa"))
            (hsPkgs."ShellCheck" or (buildDepError "ShellCheck"))
            ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.0") (hsPkgs."semigroups" or (buildDepError "semigroups"));
          buildable = true;
          mainPath = [
            "shellcheck.hs"
            ] ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.0") "";
          };
        };
      tests = {
        "test-shellcheck" = {
          depends = [
            (hsPkgs."aeson" or (buildDepError "aeson"))
            (hsPkgs."array" or (buildDepError "array"))
            (hsPkgs."base" or (buildDepError "base"))
            (hsPkgs."bytestring" or (buildDepError "bytestring"))
            (hsPkgs."containers" or (buildDepError "containers"))
            (hsPkgs."deepseq" or (buildDepError "deepseq"))
            (hsPkgs."Diff" or (buildDepError "Diff"))
            (hsPkgs."directory" or (buildDepError "directory"))
            (hsPkgs."mtl" or (buildDepError "mtl"))
            (hsPkgs."filepath" or (buildDepError "filepath"))
            (hsPkgs."parsec" or (buildDepError "parsec"))
            (hsPkgs."QuickCheck" or (buildDepError "QuickCheck"))
            (hsPkgs."regex-tdfa" or (buildDepError "regex-tdfa"))
            (hsPkgs."ShellCheck" or (buildDepError "ShellCheck"))
            ];
          buildable = true;
          mainPath = [ "test/shellcheck.hs" ];
          };
        };
      };
    } // rec { src = (pkgs.lib).mkDefault ../.; }