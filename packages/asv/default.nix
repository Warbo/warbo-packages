{ getSource, git, pythonPackages }:

pythonPackages.buildPythonPackage {
  name = "airspeed-velocity";
  src  = getSource { name = "asv"; };

  # For tests
  buildInputs = [
    git
    pythonPackages.virtualenv
    pythonPackages.pip
    pythonPackages.pytest
    pythonPackages.wheel
  ];

  # For resulting scripts
  propagatedBuildInputs = [ pythonPackages.six ];

  # Tests fail (see ./tests.nix)
  doCheck = false;
}
