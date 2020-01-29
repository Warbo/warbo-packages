{ defaultRepo, fetchgit, repoSource ? defaultRepo }:

with rec {
  src = fetchgit {
    url    = "${repoSource}/panhandle.git";
    rev    = "8985641";
    sha256 = "1db0q1lrfl98hznkvq8lcic0fvd9q585gknnjymkf2m0za9gwd9m";
  };

  pkgs = import "${src}/release.nix";
};
{
  pkg   = pkgs.exes.panhandle;
  tests = pkgs.tests;
}
