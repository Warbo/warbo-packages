{ getSource, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  name = "PyPdf2";
  src  = getSource { inherit name; };
  propagatedBuildInputs = [
    pythonPackages.python
  ];
}
