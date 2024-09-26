{ python3Packages }:

python3Packages.buildPythonPackage rec {
  pname = "translitcodec";
  version = "0.4.0";
  meta = {
    description = "Unicode to 8-bit charset transliteration codec";
    homepage = "https://pypi.python.org/pypi/translitcodec";
  };
  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "1my5azq1vqakrnrjgvvghx8434kmv455y76cmznmlbgx08d7f82l";
  };
  propagatedBuildInputs = [ python3Packages.python ];
}
