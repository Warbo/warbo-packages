{ fetchurl, pythonPackages }:

with {
  pkg = pythonPackages.buildPythonPackage rec {
    name    = "jsbeautifier";
    version = "1.10.2";

    src = fetchurl {
      url    = "https://pypi.python.org/packages/source/j/" +
               "jsbeautifier/jsbeautifier-${version}.tar.gz";
      sha256 = "1km1przbhhi4d2mdg96a53526f1p8f8q4j9nh7mnhjmmq2am3km5";
    };

    propagatedBuildInputs = with pythonPackages; [
      editorconfig
      pytest
      python
      six
    ];

    meta = {
      description = "Format and de-obfuscate javascript.";
      homepage = "http://jsbeautifier.org";
    };
  };
};
{
  inherit pkg;
  tests = {};
}
