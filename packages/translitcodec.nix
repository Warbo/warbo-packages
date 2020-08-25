{ pythonPackages, warbo-packages-sources }:

with rec {
  name   = "translitcodec";
  source = builtins.getAttr name warbo-packages-sources;
};
{
  pkg = pythonPackages.buildPythonPackage {
    inherit name;
    inherit (source) version;
    meta = { inherit (source) description homepage; };
    src  = source.outPath;
    propagatedBuildInputs = [
      pythonPackages.python
    ];
  };

  tests = {};
}
