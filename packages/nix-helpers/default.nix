# TODO: Propagate nixpkgs-lib and nixpkgs, to allow overriding. We'll need to
# bootstrap them, to prevent infinite recursion!
{ nix-helpers-args ? { } }:

import (builtins.fetchGit {
  name = "nix-helpers";
  ref = "master";
  rev = "c9756ac9e944a24291d9eba8d57f67ccf095a35e";
  url = "http://chriswarbo.net/git/nix-helpers.git";
}) nix-helpers-args
