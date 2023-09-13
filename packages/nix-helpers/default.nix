# TODO: Propagate nixpkgs-lib and nixpkgs, to allow overriding. We'll need to
# bootstrap them, to prevent infinite recursion!
{ warbo-packages-sources ? (import ../warbo-packages-sources { }) }:

import warbo-packages-sources.nix-helpers { }
