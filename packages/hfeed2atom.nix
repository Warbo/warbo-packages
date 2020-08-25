{ beautifulsoup-custom, getSource, mf2py, pythonPackages }:

{
  pkg = pythonPackages.buildPythonPackage rec {
    name                  = "hfeed2atom";
    src                   = getSource { inherit name; };
    propagatedBuildInputs = [
      pythonPackages.python
      beautifulsoup-custom
      mf2py
    ];
  };

  tests = {};
}
