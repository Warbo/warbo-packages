{ fetchTreeFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage rec {
  pname = "multibase-cli";
  version = "0.1.0";
  buildAndTestSubdir = "cli";
  cargoLock.lockFile = "${src}/Cargo.lock";
  src = fetchTreeFromGitHub {
    owner = "multiformats";
    repo = "rust-multibase";
    tree = "94b390943bb89af8b1b268688472ba2bba539b7d";
  };
}
