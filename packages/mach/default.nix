{ python3Packages }:
with {
  go =
    mkLib:
    python3Packages.callPackage (
      {
        buildPythonApplication,
        buildPythonPackage,
        fetchPypi,
      }:
      (if mkLib then buildPythonPackage else buildPythonApplication) rec {
        pname = "mach";
        version = "1.0.0";
        src = fetchPypi {
          inherit pname version;
          hash = "sha256-M6+Wr4miS85ZlUzzDJLveQ0hWyNaLtXRTNJTFxbwx98=";
        };
      }
    ) { };
};
go false // { lib = go true; }
