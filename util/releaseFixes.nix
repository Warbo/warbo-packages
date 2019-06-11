# Fixes to make packages work on whichever nixpkgs version we've pinned for
# release.nix.
# Note that this is an overlay, so shouldn't be used via callPackage
self: super:
with {
  helpers = import "${(import ../helpers.nix {
                        inherit (super) fetchgit;
                    }).nix-helpers}/overlay.nix" self super;
};
{
  inherit (helpers.nixpkgs1709) qt5;
}
