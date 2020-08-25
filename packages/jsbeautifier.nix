{ pythonPackages, warbo-packages-sources }:

with rec {
  name   = "jsbeautifier";
  source = builtins.getAttr name warbo-packages-sources;
};
{
  pkg = pythonPackages.buildPythonPackage rec {
    inherit name;
    inherit (source) version;
    meta = { inherit (source) description homepage; };
    src  = source.outPath;
    propagatedBuildInputs = with pythonPackages; [
      editorconfig
      pytest
      python
      six
    ];
  };

  tests = {};
}
