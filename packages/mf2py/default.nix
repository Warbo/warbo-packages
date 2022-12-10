{ getSource, python3Packages }:

with rec {
  mf2util = python3Packages.buildPythonPackage rec {
    name    = "mf2util";
    doCheck = false;
    src     = getSource { inherit name; };
  };

  requests = python3Packages.buildPythonPackage rec {
    name    = "requests";
    doCheck = false;
    src     = getSource { inherit name; };
  };
};
python3Packages.callPackage
  ({ beautifulsoup4, buildPythonPackage, html5lib, mock, nose }:
    buildPythonPackage rec {
      name                  = "mf2py";
      src                   = getSource { inherit name; };
      propagatedBuildInputs = [
        beautifulsoup4
        mf2util
        html5lib
        mock
        nose
        requests
      ];
    })
  {}
