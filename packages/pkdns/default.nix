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
    tree = "23901cacfdd80ebe97ee6234a79593fae7f3bdcf";
  };
  cargoLock.lockFile = "${src}/Cargo.lock";
  cargoPatches = [
    (runCommand "pkarr-local.patch" { base = ./pkarr-path.patch; } ''
      sed -e 's@PKARR_PATH@${
        fetchGit {
          url = "https://github.com/Warbo/pkarr.git";
          ref = "txt-quotes";
          rev = "743a048da2cf3026d92439005a621f7d22b658c8";
        }
      }/pkarr@g' < "$base" > "$out"
    '')
  ];
  doCheck = false; # Tests attempt to use network
  meta = with lib; {
    description = "DNS server resolving pkarr self-sovereign domains";
    homepage = "https://github.com/pubky/pkdns";
    license = licenses.mit;
    maintainers = [ ];
  };
}
