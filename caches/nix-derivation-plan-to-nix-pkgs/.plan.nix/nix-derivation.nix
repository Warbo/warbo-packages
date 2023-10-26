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
  flags = { };
  package = {
    specVersion = "1.10";
    identifier = {
      name = "nix-derivation";
      version = "1.0.2";
    };
    license = "BSD-3-Clause";
    copyright = "2017 Gabriel Gonzalez";
    maintainer = "Gabriel439@gmail.com";
    author = "Gabriel Gonzalez";
    homepage = "";
    url = "";
    synopsis = "Parse and render *.drv files";
    description = ''
      Use this package to parse and render Nix derivation files (i.e. *.drv files)

      This package also provides a @pretty-derivation@ executable which reads a
      derivation on standard input and outputs the pretty-printed Haskell
      representation on standard output'';
    buildType = "Simple";
    isLocal = true;
    detailLevel = "FullDetails";
    licenseFiles = [ "LICENSE" ];
    dataDir = "";
    dataFiles = [ ];
    extraSrcFiles = [ "tests/example0.drv" "tests/example1.drv" ];
    extraTmpFiles = [ ];
    extraDocFiles = [ ];
  };
  components = {
    "library" = {
      depends = [
        (hsPkgs."base" or (buildDepError "base"))
        (hsPkgs."attoparsec" or (buildDepError "attoparsec"))
        (hsPkgs."containers" or (buildDepError "containers"))
        (hsPkgs."deepseq" or (buildDepError "deepseq"))
        (hsPkgs."system-filepath" or (buildDepError "system-filepath"))
        (hsPkgs."text" or (buildDepError "text"))
        (hsPkgs."vector" or (buildDepError "vector"))
      ];
      buildable = true;
      modules = [
        "Nix/Derivation/Builder"
        "Nix/Derivation/Parser"
        "Nix/Derivation/Types"
        "Nix/Derivation"
      ];
      hsSourceDirs = [ "src" ];
    };
    exes = {
      "pretty-derivation" = {
        depends = [
          (hsPkgs."base" or (buildDepError "base"))
          (hsPkgs."attoparsec" or (buildDepError "attoparsec"))
          (hsPkgs."pretty-show" or (buildDepError "pretty-show"))
          (hsPkgs."text" or (buildDepError "text"))
          (hsPkgs."nix-derivation" or (buildDepError "nix-derivation"))
        ];
        buildable = true;
        hsSourceDirs = [ "pretty-derivation" ];
        mainPath = [ "Main.hs" ];
      };
    };
    tests = {
      "example" = {
        depends = [
          (hsPkgs."base" or (buildDepError "base"))
          (hsPkgs."attoparsec" or (buildDepError "attoparsec"))
          (hsPkgs."nix-derivation" or (buildDepError "nix-derivation"))
          (hsPkgs."text" or (buildDepError "text"))
        ];
        buildable = true;
        hsSourceDirs = [ "tests" ];
        mainPath = [ "Example.hs" ];
      };
      "property" = {
        depends = [
          (hsPkgs."base" or (buildDepError "base"))
          (hsPkgs."attoparsec" or (buildDepError "attoparsec"))
          (hsPkgs."nix-derivation" or (buildDepError "nix-derivation"))
          (hsPkgs."QuickCheck" or (buildDepError "QuickCheck"))
          (hsPkgs."system-filepath" or (buildDepError "system-filepath"))
          (hsPkgs."text" or (buildDepError "text"))
          (hsPkgs."vector" or (buildDepError "vector"))
        ];
        buildable = true;
        hsSourceDirs = [ "tests" ];
        mainPath = [ "Property.hs" ];
      };
    };
    benchmarks = {
      "benchmark" = {
        depends = [
          (hsPkgs."base" or (buildDepError "base"))
          (hsPkgs."attoparsec" or (buildDepError "attoparsec"))
          (hsPkgs."criterion" or (buildDepError "criterion"))
          (hsPkgs."nix-derivation" or (buildDepError "nix-derivation"))
          (hsPkgs."text" or (buildDepError "text"))
        ];
        buildable = true;
        hsSourceDirs = [ "bench" ];
      };
    };
  };
} // rec {
  src = (pkgs.lib).mkDefault ../.;
}
