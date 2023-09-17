{ getSource, lib, nixpkgs1609, skipARM }:

skipARM "coq-mtac" (lib.overrideDerivation nixpkgs1609.coq (oldAttrs: rec {
  name = "coq-mtac";
  src = getSource { inherit name; };
}))
