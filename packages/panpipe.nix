{ haskellOverride, nixpkgs1609 }:

(haskellOverride {
  haskellPackages = nixpkgs1609.haskellPackages;
  panPkgs         = true;
}).panpipe
