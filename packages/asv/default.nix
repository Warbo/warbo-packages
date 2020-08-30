{ getSource, git, isBroken, pkgHasBinary, pythonPackages }:

with rec {
  plain = pythonPackages.buildPythonPackage {
    name = "airspeed-velocity";
    src  = getSource { name = "asv"; };

    # For tests
    buildInputs = [
      git
      pythonPackages.virtualenv
      pythonPackages.pip
      pythonPackages.wheel
    ];

    # For resulting scripts
    propagatedBuildInputs = [ pythonPackages.six ];
  };

  pkg = plain.override (old: {
    stillNeedToDisableTests = isBroken plain;
    doCheck = false;
  });
};

{
  pkg   = pkgHasBinary "asv" pkg;
  tests = {};
}
