{ getSource, pkgHasBinary, stdenv }:

{
  pkg = pkgHasBinary "bibclean"
    (stdenv.mkDerivation rec {
      name       = "bibclean";
      src        = getSource { inherit name; };
      preInstall = ''
        mkdir -p "$out/bin"
        mkdir -p "$out/man/man1"
      '';
    });

  tests = {};
}
