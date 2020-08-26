{ getSource, hasBinary, haskellSrc2nix, lib, nixpkgs1803 }:

rec {
  pkg   = lib.makeOverridable
    ({ haskellPackages }:
    haskellPackages.callPackage (haskellSrc2nix rec {
      name = "nix-delegate";
      src  = getSource { inherit name; };
    }) {})
    { inherit (nixpkgs1803) haskellPackages; };

  tests = hasBinary pkg "nix-delegate";
}
