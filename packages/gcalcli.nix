{ die, hasBinary, lib, google-api-python-client, nixpkgs1803,
  warbo-packages-sources }:

with builtins;
with lib;
with rec {
  name   = "gcalcli";
  source = builtins.getAttr name warbo-packages-sources;
};
rec {
  pkg =
    with rec {
      inherit (nixpkgs1803) pythonPackages;
      got  = pythonPackages.oauth2client.name;
      want = "1.4.12";
    };
    assert hasSuffix want got || die {
      inherit got want;
      error = "oauth2client version should be <= ${want}";
    };
    pythonPackages.buildPythonPackage {
      inherit name;
      inherit (source) version;
      src                   = source.outPath;
      propagatedBuildInputs = [
        pythonPackages.python
        pythonPackages.gflags
        pythonPackages.dateutil
        pythonPackages.vobject
        pythonPackages.parsedatetime
        pythonPackages.httplib2
        pythonPackages.oauth2client
        (google-api-python-client.override {
          inherit pythonPackages;
          uritemplate = uritemplate.override {
            inherit pythonPackages;
          };
        })
      ];
    };

  tests = hasBinary pkg "gcalcli";
}
