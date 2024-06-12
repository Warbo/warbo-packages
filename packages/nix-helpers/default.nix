# TODO: Propagate nixpkgs-lib and nixpkgs, to allow overriding. We'll need to
# bootstrap them, to prevent infinite recursion!
{
  nix-helpers-args ? { },
}:

import (builtins.fetchGit {
  name = "nix-helpers";
  ref = "master";
  rev = "294b3a2e12b60a0947349c5ceccdcd76b4a592a0";
  url = "http://chriswarbo.net/git/nix-helpers.git";
}) nix-helpers-args
