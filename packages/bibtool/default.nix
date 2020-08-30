{ getSource, pkgHasBinary, stdenv}:

{
  pkg = pkgHasBinary "bibtool"
    (stdenv.mkDerivation rec {
      name = "bibtool";
      src  = getSource { inherit name; };
    });
  tests = {};
}
