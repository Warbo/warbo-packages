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

  # TODO: This should be removed once the above qt5 override is no longer needed
  v4l_utils = self.newScope
    self.qt5
    "${helpers.repo1903}/pkgs/os-specific/linux/v4l-utils"
    {};
}
