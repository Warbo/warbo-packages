# TODO: Propagate nixpkgs-lib and nixpkgs, to allow overriding. We'll need to
# bootstrap them, to prevent infinite recursion!
{ nix-helpers-args ? { } }:

import (builtins.fetchGit {
  name = "nix-helpers";
  ref = "master";
  rev = "c13501732f45671846b57b4bd65e1e11466657cc";
  url = "http://chriswarbo.net/git/nix-helpers.git";
}) nix-helpers-args
