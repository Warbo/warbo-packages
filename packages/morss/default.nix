{ fetchPypi, python3Packages, writeShellApplication }:
python3Packages.buildPythonApplication rec {
  pname = "morss";
  version = "20230627.2039";
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-xAGsKSHYHx0vjsMu8QfFdO/7S4mQXELVGjBqaSiMfDw=";
  };
  propagatedBuildInputs = with python3Packages; [
    beautifulsoup4 chardet dateutil lxml
  ];
  passthru.lib = python3Packages.buildPythonPackage {
    inherit pname version src propagatedBuildInputs;
  };
}
