# TODO: Propagate nixpkgs-lib and nixpkgs, to allow overriding. We'll need to
# bootstrap them, to prevent infinite recursion!
{ nix-helpers-args ? { } }:

import (builtins.fetchGit {
  name = "nix-helpers";
  ref = "master";
  rev = "36709e71b2e2f7fad5ef2d9bb34f9bf225d04cc0";
  url = "http://chriswarbo.net/git/nix-helpers.git";
}) nix-helpers-args
