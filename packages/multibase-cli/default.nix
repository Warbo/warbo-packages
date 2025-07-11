{ fetchTreeFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage rec {
  pname = "multibase-cli";
  version = "0.1.0";
  buildAndTestSubdir = "cli";
  cargoLock.lockFile = "${src}/Cargo.lock";
  src = fetchTreeFromGitHub {
    owner = "Warbo";
    repo = "rust-multibase";
    tree = "269638580b024dd8a580ee495a391ff374b34c4e";
  };
}
