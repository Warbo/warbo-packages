{ lib, pythonPackages, warbo-packages-sources }:

with rec {
  name   = "uritemplate";
  source = builtins.getAttr name warbo-packages-sources;
};
{
  pkg   = lib.makeOverridable
    ({ pythonPackages }: pythonPackages.buildPythonPackage {
      inherit name;
      inherit (source) version;
      src                   = source.outPath;
      propagatedBuildInputs = [
        pythonPackages.python
        pythonPackages.simplejson
      ];
    })
    { inherit pythonPackages; };

  tests = {};
}
