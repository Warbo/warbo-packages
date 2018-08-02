{ fetchFromGitHub, git, isBroken, pkgHasBinary, pythonPackages }:

with rec {
  plain = pythonPackages.buildPythonPackage {
    name = "airspeed-velocity";
    src  = fetchFromGitHub {
      owner  = "spacetelescope";
      repo   = "asv";
      rev    = "0e0ca65";
      sha256 = "1lzdk4f2xd77jmf8048kzam7ad7b05az4zh6mgq16snymrdifqij";
    };

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

pkgHasBinary "asv" pkg
