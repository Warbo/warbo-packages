{ getSource, python3Packages }:

with {
  mf2util = { buildPythonPackage, fetchPypi, mf2py, pytest }:
    buildPythonPackage rec {
      pname = "mf2util";
      version = "0.5.2";
      nativeCheckInputs = [ mf2py pytest ];
      doCheck = false; # Claims to use pytest but there are no tests so it fails
      src = fetchPypi {
        inherit pname version;
        hash = "sha256-69R+tObtZvmcDktxi7J3v7jf9IhiXkBzvwYmHGQmhrM=";
      };
    };
};

python3Packages.callPackage
({ beautifulsoup4, buildPythonPackage, callPackage, mf2py }:
  buildPythonPackage rec {
    name = "hfeed2atom";
    src = getSource { inherit name; };
    propagatedBuildInputs = [ beautifulsoup4 mf2py (callPackage mf2util { }) ];
    doCheck = false; # There are no tests, so setup.py fails
    postUnpack = ''
      # Avoid circular import (using Python2 imports in Python3?)
      sed -e 's/from hfeed2atom/from .hfeed2atom/g' \
          -i hfeed2atom-src/hfeed2atom/__init__.py
    '';
  }) { }
