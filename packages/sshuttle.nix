{ hasBinary, nixpkgs1603 }:

rec {
  pkg   = nixpkgs1603.sshuttle;

  tests = hasBinary pkg "sshuttle";
}
