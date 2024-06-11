{
  pythonPackages,
  uritemplate,
  warbo-packages-sources,
}:

with rec {
  name = "google-api-python-client";
  source = builtins.getAttr name warbo-packages-sources;
};
pythonPackages.buildPythonPackage {
  inherit name;
  inherit (source) version;
  src = source.outPath;
  propagatedBuildInputs = [
    pythonPackages.python
    pythonPackages.six
    uritemplate
    pythonPackages.httplib2
    pythonPackages.oauth2client
  ];
}
