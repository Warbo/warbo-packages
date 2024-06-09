with rec {
  inherit (import ./. {}) nix-helpers;
  inherit (nix-helpers) nixpkgs pinnedNiv;
};
nixpkgs.stdenv.mkDerivation {
  name = "warbo-packages-env";
  buildInputs = [ pinnedNiv ];
}
