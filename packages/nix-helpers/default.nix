# TODO: Propagate nixpkgs-lib and nixpkgs, to allow overriding. We'll need to
# bootstrap them, to prevent infinite recursion!
{
  nix-helpers-args ? { },
}:

import (builtins.fetchGit {
  name = "nix-helpers";
  ref = "master";
  rev = "120a170a3a92ecf08b49d712cf1209c74509d1db";
  url = "http://chriswarbo.net/git/nix-helpers.git";
}) nix-helpers-args
