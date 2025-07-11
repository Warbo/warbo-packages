{
  lib,
  fetchTreeFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "pkdns-server";
  version = "0.7.0-rc.3";
  src = fetchTreeFromGitHub {
    owner = "pubky";
    repo = "pkdns";
    tree = "2d3e533e8616716606fd227b74aa9cdd535e3dfb";
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
