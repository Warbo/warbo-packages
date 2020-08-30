{ hasBinary, isBroken, pythonPackages, runCommand, warbo-packages-sources,
  withDeps }:

with rec {
  name   = "linkchecker";
  source = builtins.getAttr name warbo-packages-sources;
  meta   = { inherit (source) description homepage; };
  pkg    = pythonPackages.buildPythonPackage rec {
    inherit name;

    # Works around ridiculous hand-rolled lexicographical version-checking
    # nonsense, as per https://github.com/wummel/linkchecker/issues/649
    src = runCommand "linkchecker-patched" { pristine = source.outPath; } ''
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
  };

  notests = withDeps [ (isBroken pkg) ] (pkg.overrideAttrs (old: {
                                          doInstallCheck = false;
                                        }));
};
{
  pkg   = notests;
  tests = hasBinary notests "linkchecker";
}
