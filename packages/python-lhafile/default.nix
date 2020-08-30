{ pythonPackages, warbo-packages-sources }:

with rec {
  name   = "python-lhafile";
  source = builtins.getAttr name warbo-packages-sources;
};
{
  pkg = pythonPackages.buildPythonPackage {
    inherit name;
    inherit (source) version;
    src                   = source.outPath;
    propagatedBuildInputs = [ pythonPackages.python ];
  };

  tests = {};
}
