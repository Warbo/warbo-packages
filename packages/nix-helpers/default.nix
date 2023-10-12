# TODO: Propagate nixpkgs-lib and nixpkgs, to allow overriding. We'll need to
# bootstrap them, to prevent infinite recursion!
{ nix-helpers-args ? { } }:

import (builtins.fetchGit {
  name = "nix-helpers";
  ref = "master";
  rev = "b5bca8d45026c826202d728b376effc672172c21";
  url = "http://chriswarbo.net/git/nix-helpers.git";
}) nix-helpers-args
