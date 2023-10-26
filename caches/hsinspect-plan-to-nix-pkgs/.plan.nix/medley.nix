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
    uncompilable = true;
    ghcflags = false;
  };
  package = {
    specVersion = "2.2";
    identifier = {
      name = "medley";
      version = "0.0.1";
    };
    license = "NONE";
    copyright = "";
    maintainer = "";
    author = "";
    homepage = "";
    url = "";
    synopsis = "";
    description = "";
    buildType = "Simple";
    isLocal = true;
    detailLevel = "FullDetails";
    licenseFiles = [ ];
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
        (hsPkgs."contravariant" or (buildDepError "contravariant"))
      ] ++ (pkgs.lib).optional (flags.ghcflags)
        (hsPkgs."ghcflags" or (buildDepError "ghcflags"));
      buildable = true;
      modules = [ "Medley/Wibble" "Medley/Wobble" ];
      hsSourceDirs = [ "library" ];
    };
  };
} // rec {
  src = (pkgs.lib).mkDefault ../tests/medley;
}
