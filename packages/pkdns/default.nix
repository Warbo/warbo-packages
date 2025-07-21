{
  lib,
  fetchTreeFromGitHub,
  rustPlatform,
  runCommand,
}:
rustPlatform.buildRustPackage rec {
  pname = "pkdns-server";
  version = "0.7.0-rc.3";
  src = fetchTreeFromGitHub {
    owner = "pubky";
    repo = "pkdns";
    tree = "7e261baf04fc48c4773adff87455f5cbb27a7ab6";
  };
  cargoLock.lockFile = "${src}/Cargo.lock";
  doCheck = false; # Tests attempt to use network
  meta = with lib; {
    description = "DNS server resolving pkarr self-sovereign domains";
    homepage = "https://github.com/pubky/pkdns";
    license = licenses.mit;
    maintainers = [ ];
  };
}
