# TODO: Propagate nixpkgs-lib and nixpkgs, to allow overriding. We'll need to
# bootstrap them, to prevent infinite recursion!
{ nix-helpers-args ? { } }:

import (builtins.fetchGit {
  name = "nix-helpers";
  ref = "master";
  rev = "d222d6d28ca8f2d098bb507f99408f1e2e7c744e";
  url = "http://chriswarbo.net/git/nix-helpers.git";
}) nix-helpers-args
