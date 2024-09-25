# TODO: Propagate nixpkgs-lib and nixpkgs, to allow overriding. We'll need to
# bootstrap them, to prevent infinite recursion!
{
  nix-helpers-args ? { },
}:

import (builtins.fetchGit {
  name = "nix-helpers";
  ref = "master";
  rev = "bda41ce6316ac77cd963adf5b95cc7cf095242d0";
  url = "http://chriswarbo.net/git/nix-helpers.git";
}) nix-helpers-args
