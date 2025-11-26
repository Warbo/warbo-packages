{
  lib,
  fetchTreeFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "pkdns-server";
  version = "0.7.0-rc.3";
  src = fetchTreeFromGitHub {
    owner = "Warbo";
    repo = "pkdns";
    tree = "b438b62d33fa7a5a9c97ec6f0a0b08d63a90ab71";
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
