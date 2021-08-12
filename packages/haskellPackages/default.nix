# Like haskellPackages in nixpkgs, but overridden using haskellOverride
#
# This is a little awkwards, since we might want to use the same
# haskellPackages.override API as nixpkgs provides, but that gets wiped out when
# we use 'callPackage' to load this package. Hence we try to emulate that API.
{
  # "Normal" inputs
  haskellOverride
, super

  # Accepting this argument makes us act like nixpkgs
, overrides ? (helf: huper: {})

  # As a final catch-all, this can be used to manipulate the result, before
  # 'callPackage' gets a chance to add its own override mechanism
, post ? (x: x)
}:

post (haskellOverride {
  inherit (super) haskellPackages;
  extra = [ overrides ];
})
