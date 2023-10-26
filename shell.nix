with {
  inherit (import (import ./nix/sources.nix).nix-helpers)
    nixpkgsLatest pinnedNiv;
};
nixpkgsLatest.stdenv.mkDerivation {
  name = "warbo-packages-env";
  buildInputs = [ pinnedNiv ];
}
