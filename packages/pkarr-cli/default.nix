{ fetchTreeFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage rec {
  pname = "pkarr-cli";
  version = "0.1.2";
  buildAndTestSubdir = "cli";
  cargoLock.lockFile = "${src}/Cargo.lock";
  src = fetchTreeFromGitHub {
    owner = "Nuhvi";
    repo = "/pkarr";
    tree = "184a96bee82c69709300be91781c14b8a565e77d";
  };
}
