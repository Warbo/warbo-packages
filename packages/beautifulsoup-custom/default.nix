{ getSource, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  name = "beautiful-soup";
  src  = getSource { inherit name; };
}
