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
    owner = "Warbo";
    repo = "pkdns";
    tree = "ca807daa0d557f6d3e7f2b29198cab07db3d4d00";
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
