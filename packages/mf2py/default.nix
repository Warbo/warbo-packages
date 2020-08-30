{ beautifulsoup-custom, getSource, pythonPackages }:

with rec {
  mf2util = pythonPackages.buildPythonPackage rec {
    name    = "mf2util";
    doCheck = false;
    src     = getSource { inherit name; };
  };

  requests = pythonPackages.buildPythonPackage rec {
    name    = "requests";
    doCheck = false;
    src     = getSource { inherit name; };
  };
};
{
  pkg = pythonPackages.buildPythonPackage rec {
    name                  = "mf2py";
    src                   = getSource { inherit name; };
    propagatedBuildInputs = [
      beautifulsoup-custom
      mf2util
      pythonPackages.html5lib
      pythonPackages.mock
      pythonPackages.nose
      pythonPackages.python
      requests
    ];
  };

  tests = {};
}
