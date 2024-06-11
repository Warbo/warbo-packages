let
  buildDepError =
    pkg:
    builtins.throw ''
      The Haskell package set does not contain the package: ${pkg} (build dependency).

      If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.
    '';
  sysDepError =
    pkg:
    builtins.throw ''
      The Nixpkgs package set does not contain the package: ${pkg} (system dependency).

      You may need to augment the system package mapping in haskell.nix so that it can be found.
    '';
  pkgConfDepError =
    pkg:
    builtins.throw ''
      The pkg-conf packages does not contain the package: ${pkg} (pkg-conf dependency).

      You may need to augment the pkg-conf package mapping in haskell.nix so that it can be found.
    '';
  exeDepError =
    pkg:
    builtins.throw ''
      The local executable components do not include the component: ${pkg} (executable dependency).
    '';
  legacyExeDepError =
    pkg:
    builtins.throw ''
      The Haskell package set does not contain the package: ${pkg} (executable dependency).

      If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.
    '';
  buildToolDepError =
    pkg:
    builtins.throw ''
      Neither the Haskell package set or the Nixpkgs package set contain the package: ${pkg} (build tool dependency).

      If this is a system dependency:
      You may need to augment the system package mapping in haskell.nix so that it can be found.

      If this is a Haskell dependency:
      If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.
    '';
in
{
  system,
  compiler,
  flags,
  pkgs,
  hsPkgs,
  pkgconfPkgs,
  ...
}:
{
  flags = { };
  package = {
    specVersion = "1.10";
    identifier = {
      name = "GetDeps";
      version = "0.2.0.0";
    };
    license = "GPL-3.0-only";
    copyright = "";
    maintainer = "chriswarbo@gmail.com";
    author = "Chris Warburton";
    homepage = "http://chriswarbo.net/git/get-deps";
    url = "";
    synopsis = "Feature extraction for tree structured data";
    description = "";
    buildType = "Simple";
    isLocal = true;
    detailLevel = "FullDetails";
    licenseFiles = [ "LICENSE" ];
    dataDir = "";
    dataFiles = [ ];
    extraSrcFiles = [ "README" ];
    extraTmpFiles = [ ];
    extraDocFiles = [ ];
  };
  components = {
    "library" = {
      depends = [
        (hsPkgs."base" or (buildDepError "base"))
        (hsPkgs."parsec" or (buildDepError "parsec"))
        (hsPkgs."atto-lisp" or (buildDepError "atto-lisp"))
        (hsPkgs."stringable" or (buildDepError "stringable"))
        (hsPkgs."bytestring" or (buildDepError "bytestring"))
        (hsPkgs."attoparsec" or (buildDepError "attoparsec"))
        (hsPkgs."aeson" or (buildDepError "aeson"))
      ];
      buildable = true;
      modules = [
        "GetDeps"
        "SexprHelper"
        "Types"
      ];
      hsSourceDirs = [ "src" ];
    };
    exes = {
      "GetDeps" = {
        depends = [
          (hsPkgs."base" or (buildDepError "base"))
          (hsPkgs."parsec" or (buildDepError "parsec"))
          (hsPkgs."atto-lisp" or (buildDepError "atto-lisp"))
          (hsPkgs."stringable" or (buildDepError "stringable"))
          (hsPkgs."bytestring" or (buildDepError "bytestring"))
          (hsPkgs."attoparsec" or (buildDepError "attoparsec"))
          (hsPkgs."aeson" or (buildDepError "aeson"))
        ];
        buildable = true;
        hsSourceDirs = [ "src" ];
        mainPath = [ "Main.hs" ];
      };
    };
    tests = {
      "tests" = {
        depends = [
          (hsPkgs."base" or (buildDepError "base"))
          (hsPkgs."QuickCheck" or (buildDepError "QuickCheck"))
          (hsPkgs."tasty" or (buildDepError "tasty"))
          (hsPkgs."tasty-quickcheck" or (buildDepError "tasty-quickcheck"))
          (hsPkgs."parsec" or (buildDepError "parsec"))
          (hsPkgs."atto-lisp" or (buildDepError "atto-lisp"))
          (hsPkgs."stringable" or (buildDepError "stringable"))
          (hsPkgs."bytestring" or (buildDepError "bytestring"))
          (hsPkgs."attoparsec" or (buildDepError "attoparsec"))
          (hsPkgs."aeson" or (buildDepError "aeson"))
        ];
        buildable = true;
        hsSourceDirs = [
          "tests"
          "src"
        ];
        mainPath = [ "Main.hs" ];
      };
    };
  };
}
// rec {
  src = (pkgs.lib).mkDefault ../.;
}
