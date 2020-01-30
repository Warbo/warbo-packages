{ defaultRepo, fetchgit, repoSource ? defaultRepo }:

with rec {
  src = fetchgit {
    url    = "${repoSource}/panhandle.git";
    rev    = "bab9580";
    sha256 = "0c2l7bvkxy7q41r9fyxq9jzpq2b10n1nkwhi0b8rqlr8h41p96ad";
  };

  pkgs = import "${src}/release.nix";
};
{
  pkg   = pkgs.exes.panhandle;
  tests = pkgs.tests;
}
