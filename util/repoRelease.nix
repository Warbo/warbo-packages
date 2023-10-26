# The repoXXXX equivalent to nixpkgsRelease
{ lib, nixpkgsRelease, pinnedNixpkgs, repoLatest }:

# Only use the first 4 chars in case we have e.g. "1234pre-git"
with {
  inherit (builtins) attrNames getAttr hasAttr toJSON trace;
  repo = "repo" + lib.substring 0 4 nixpkgsRelease;
};
if hasAttr repo pinnedNixpkgs then
  getAttr repo pinnedNixpkgs
else
  trace (toJSON {
    inherit repo;
    warning = "Repo not found in pinnedNixpkgs, using latest";
    available = attrNames pinnedNixpkgs;
  }) repoLatest
