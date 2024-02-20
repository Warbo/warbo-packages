# TODO: Propagate nixpkgs-lib and nixpkgs, to allow overriding. We'll need to
# bootstrap them, to prevent infinite recursion!
{ nix-helpers-args ? { } }:

import (builtins.fetchGit {
  name = "nix-helpers";
  ref = "master";
  rev = "7db97b9bf27fc20bae2eb66d47d821d8133ac151";
  url = "http://chriswarbo.net/git/nix-helpers.git";
}) nix-helpers-args
