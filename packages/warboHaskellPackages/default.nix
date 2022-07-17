# Like haskellPackages in nixpkgs, but overridden using haskellOverride
#
# This is a little awkward, since we might want to use the same
# haskellPackages.override API as nixpkgs provides, but that gets wiped out when
# we use 'callPackage' to load this package. Hence we try to emulate that API.
{
  # "Normal" inputs
  warboHaskellOverride
, super

  # Accepting this argument makes us act like nixpkgs
, overrides ? (helf: huper: {})

  # As a final catch-all, this can be used to manipulate the result, before
  # 'callPackage' gets a chance to add its own override mechanism
, post ? (x: x)
}:

if super.stdenv.isDarwin
   then builtins.trace "Skipping warbo-packages warboHaskellOverride on macOS"
                       super.haskellPackages
   else post (warboHaskellOverride {
     inherit (super) haskellPackages;
     extra = [ overrides ];
   })
