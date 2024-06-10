# TODO: Propagate nixpkgs-lib and nixpkgs, to allow overriding. We'll need to
# bootstrap them, to prevent infinite recursion!
{ nix-helpers-args ? { } }:

import (builtins.fetchGit {
  name = "nix-helpers";
  ref = "master";
  rev = "c7968c06e102ead53cbb8d79a6ca1082818677d4";
  url = "http://chriswarbo.net/git/nix-helpers.git";
}) nix-helpers-args
