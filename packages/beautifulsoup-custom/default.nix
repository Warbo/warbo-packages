{ getSource, pythonPackages }:

{
  pkg = pythonPackages.buildPythonPackage rec {
    name = "beautiful-soup";
    src  = getSource { inherit name; };
  };
  tests = {};
}
