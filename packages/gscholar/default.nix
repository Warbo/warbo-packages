{ pythonPackages, poppler_utils, warbo-packages-sources }:

with rec {
  name   = "gscholar";
  source = builtins.getAttr name warbo-packages-sources;
};
{
  pkg = pythonPackages.buildPythonPackage rec {
    inherit name;
    inherit (source) version;
    meta = { inherit (source) description homepage; };
    src  = source.outPath;
    preInstallPhases      = [ "bins" ];
    propagatedBuildInputs = [
      pythonPackages.python
      poppler_utils
    ];
    bins = ''
      mkdir -p "$out/bin"
      cp ./gscholar/gscholar.py "$out/bin"
    '';
  };

  tests = {};
}
