{ fetchTreeFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage rec {
  pname = "multibase-cli";
  version = "0.1.0";
  buildAndTestSubdir = "cli";
  cargoLock.lockFile = "${src}/Cargo.lock";
  src = fetchTreeFromGitHub {
    owner = "Warbo";
    repo = "rust-multibase";
    tree = "b19a5df258b5ef84b6a2e095fba888f6d326d424";
  };
}
