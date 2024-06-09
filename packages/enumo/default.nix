{ crate2nix-tools
, fetchFromGitHub
, runCommand
, nixpkgs
, enumo-src ? fetchFromGitHub {
  owner = "uwplse";
  repo = "ruler";
  rev = "d0c219805bc83f7949c4e487528a389d078c28c1";
  hash = "sha256-gJavTUdeiTpiVmWl3d2EbRG3NN/IGwejh74I0ty+5ww=";
}
, cargoLock ? ./Cargo.lock
, egg ? nixpkgs.callPackage (crate2nix-tools.generatedCargoNix {
  name = "egg";
  src = nixpkgs.fetchCrate {
    crateName = "egg";
    version = "0.9.0";
    hash = "sha256-Z3s16wJqKjLc+gGWgJ356HhsrRjsID74leaOpRQVExw=";
  };
}) {}}:
crate2nix-tools.generatedCargoNix {
  name = "ruler";
  src = if cargoLock == null then enumo-src else
    runCommand "enumo-with-lock" { inherit cargoLock; orig = enumo-src; } ''
      cp -r "$orig" "$out"
      chmod +w "$out"
      cp "$cargoLock" "$out/Cargo.lock"
    '';
} // { inherit egg; }
