# TODO: Propagate nixpkgs-lib and nixpkgs, to allow overriding. We'll need to
# bootstrap them, to prevent infinite recursion!
{ nix-helpers-args ? { } }:

import (builtins.fetchGit {
  name = "nix-helpers";
  ref = "master";
  rev = "60a8faf06dc092722268dd60dc253f065856a2a6";
  url = "http://chriswarbo.net/git/nix-helpers.git";
}) nix-helpers-args
