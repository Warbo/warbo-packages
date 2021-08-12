{ getSource, hsPkgs ? nixpkgs1803.haskellPackages, haskellSrc2nix, lib,
  nixpkgs1803 }:

with {
  inherit (builtins) trace;
  inherit (lib) hasSuffix;

  pkg = hsPkgs.callPackage (haskellSrc2nix rec {
    name = "nix-delegate";
    src  = getSource { inherit name; };
  }) {};
};
if hasSuffix "-darwin" nixpkgs1803.system
   then trace "Skipping nix-delegate on macOS, since Haskell's broken" null
   else null
