{
  fetchTreeFromGitHub,
  python3Packages,
  stdenv,
}:

python3Packages.buildPythonPackage {
  name = "bibcheck";
  version = "2015-10-22";
  src = fetchTreeFromGitHub {
    owner = "rmcgibbo";
    repo = "bibcheck";
    tree = "6064afa77028e37c7e3128627f37db02351fbd58";
  };
  propagatedBuildInputs = [
    python3Packages.python
    python3Packages.six
  ];
}
