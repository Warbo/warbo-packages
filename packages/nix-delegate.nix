{ getSource, hasBinary, lib, nixpkgs1803 }:

rec {
  pkg   = lib.makeOverridable
    ({ haskellPackages }:
      haskellPackages.callPackage (getSource { name = "nix-delegate"; }) {})
    { inherit (nixpkgs1803) haskellPackages; };

  tests = hasBinary pkg "nix-delegate";
}
