{ pythonPackages, warbo-packages-sources }:

with rec {
  name   = "uritemplate";
  source = builtins.getAttr name warbo-packages-sources;
};
pythonPackages.buildPythonPackage {
  inherit name;
  inherit (source) version;
  src                   = source.outPath;
  propagatedBuildInputs = [
    pythonPackages.python
    pythonPackages.simplejson
  ];
}
