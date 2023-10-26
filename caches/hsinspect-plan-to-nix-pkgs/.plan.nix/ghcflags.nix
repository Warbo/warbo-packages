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
    specVersion = "2.2";
    identifier = {
      name = "ghcflags";
      version = "1.0.3";
    };
    license = "BSD-2-Clause";
    copyright = "2019 Tseen She";
    maintainer = "Tseen She";
    author = "Tseen She";
    homepage = "";
    url = "";
    synopsis = "Dump the ghc flags during compilation";
    description = "Generate @.ghc.flags@ files during compilation";
    buildType = "Simple";
    isLocal = true;
    detailLevel = "FullDetails";
    licenseFiles = [ "LICENSE" ];
    dataDir = "";
    dataFiles = [ ];
    extraSrcFiles = [ ];
    extraTmpFiles = [ ];
    extraDocFiles = [ ];
  };
  components = {
    "library" = {
      depends = [
        (hsPkgs."base" or (buildDepError "base"))
        (hsPkgs."directory" or (buildDepError "directory"))
        (hsPkgs."ghc" or (buildDepError "ghc"))
        (hsPkgs."time" or (buildDepError "time"))
      ];
      buildable = true;
      modules = [ "GhcFlags/Plugin" ];
      hsSourceDirs = [ "." ];
    };
  };
} // rec {
  src = (pkgs.lib).mkDefault ../plugin;
}
