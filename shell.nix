with rec {
  inherit (import ./. { }) nix-helpers;
  inherit (nix-helpers) nixpkgs pinnedNiv;
};
nix-helpers.shellWithHooks {
  name = "warbo-packages";
  src = ./.;
  buildInputs = [
    pinnedNiv
    nixpkgs.update-nix-fetchgit
  ];
}
