{ getSource, gnumake, hasBinary, lhasa, stdenv }:

rec {
  pkg = stdenv.mkDerivation {
    name = "xdms";

    src = getSource { name = "xdms"; };

    buildInputs = [ lhasa gnumake ];

    unpackPhase = ''
      lha x /nix/store/hhihia6jr25l4wwrf0g6yhdr743nlywn-xDMS.lha
    '';

    buildPhase = ''
      cd xdms/src
      make
    '';

    installPhase = ''
      cd ..
      mkdir -p "$out/bin"
      cp src/xdms "$out/bin"
      cp Linux-bin/readdisk "$out/bin"
    '';
  };

  tests = hasBinary pkg "xdms";
}
