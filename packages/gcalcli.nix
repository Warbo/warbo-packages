{ die, fetchurl, hasBinary, lib, google-api-python-client, nixpkgs1803,
  uritemplate }:

with builtins;
with lib;
with rec {
  inherit (nixpkgs1803) pythonPackages;
  got  = pythonPackages.oauth2client.name;
  want = "1.4.12";
};
assert hasSuffix want got || die {
  inherit got want;
  error = "oauth2client version should be <= ${want}";
};
rec {
  pkg = pythonPackages.buildPythonPackage {
    name = "gcalcli";
    version = "3.3.2";

    src = fetchurl {
      url = https://pypi.python.org/packages/source/g/gcalcli/gcalcli-3.3.2.tar.gz;
      sha256 = "0yw60zgh2ski46mxsyncwx4bb6zzrfp5bn91hg0xyvmz71339mkj";
    };

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
