{
  fetchPypi,
  python3Packages,
}:
python3Packages.buildPythonApplication rec {
  pname = "morss";
  version = "20230627.2039";
  pyproject = true;
  build-system = [ python3Packages.setuptools ];
  dontCheckRuntimeDeps = true; # Avoids "bs4 not installed"
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-xAGsKSHYHx0vjsMu8QfFdO/7S4mQXELVGjBqaSiMfDw=";
  };
  propagatedBuildInputs = with python3Packages; [
    beautifulsoup4
    chardet
    python-dateutil
    lxml
  ];
  passthru.lib = python3Packages.buildPythonPackage {
    inherit
      pname
      pyproject
      build-system
      dontCheckRuntimeDeps
      version
      src
      propagatedBuildInputs
      ;
  };
}
