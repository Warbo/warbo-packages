{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "pkdns-server";
  version = "0.7.0-rc.3";
  src = fetchFromGitHub {
    owner = "pubky";
    repo = "pkdns";
    rev = "80f3277dfc25e5523be91d13909f716ca8af22fb";
    hash = "sha256-/N7QOt0YM7e5Wr76dxBIU+K0F1syMGyRg9vfmKVfmpg=";
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
