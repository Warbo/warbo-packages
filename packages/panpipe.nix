{ defaultRepo, fetchgit, repoSource ? defaultRepo }:

with rec {
  src = fetchgit {
    url    = "${repoSource}/panpipe.git";
    rev    = "24734f6";
    sha256 = "178xs0h29ygj3f1vs8p9gb278816zi1gmnks7j7bgdlx7c7ymd3v";
  };

  pkgs = import src;
};
{
  pkg   = pkgs.panpipe.components.exes.panpipe;
  tests = pkgs.panpipe.components.tests;
}
