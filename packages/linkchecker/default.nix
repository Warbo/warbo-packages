{ pythonPackages, runCommand, warbo-packages-sources }:

with rec {
  name     = "linkchecker";
  pristine = builtins.getAttr name warbo-packages-sources;
};
pythonPackages.buildPythonPackage rec {
  inherit name;
  meta    = { inherit (pristine) description homepage; };
  doCheck = false;

  # Works around ridiculous hand-rolled lexicographical version-checking
  # nonsense, as per https://github.com/wummel/linkchecker/issues/649
  src = runCommand "linkchecker-patched" { inherit pristine; } ''
    cp -r "$pristine" "$out"
    chmod +w -R "$out"
    mkdir -p "$out/doc/html"
    for F in lccollection.qhc lcdoc.qch
    do
      touch "$out/doc/html/$F"
    done
  '';

  propagatedBuildInputs = [
    pythonPackages.pytest
    pythonPackages.python
    pythonPackages.requests
  ];
}
