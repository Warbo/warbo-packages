# TODO: Propagate nixpkgs-lib and nixpkgs, to allow overriding. We'll need to
# bootstrap them, to prevent infinite recursion!
{ nix-helpers-args ? { } }:

import (builtins.fetchGit {
  name = "nix-helpers";
  ref = "master";
  rev = "9bed246bfc3694e42e50f77b487fcb978a7eaaeb";
  url = "http://chriswarbo.net/git/nix-helpers.git";
}) nix-helpers-args
