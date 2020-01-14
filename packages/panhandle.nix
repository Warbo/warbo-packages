{ defaultRepo, fetchgit, repoSource ? defaultRepo }:

with rec {
  src = fetchgit {
    url    = "${repoSource}/panhandle.git";
    rev    = "45fd71d";
    sha256 = "0sg4w5vxn5p9wa5slhybp9hbqqvxg20jrh8qpa98nkx5h1vbn7lr";
  };

  pkgs = import src;
};
{
  pkg   = pkgs.panhandle.components.exes.panhandle;
  tests = pkgs.panhandle.components.tests;
}
