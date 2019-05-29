{ die, fetchurl, hasBinary, lib, pythonPackages, google-api-python-client }:

with builtins;
rec {
  pkg = lib.makeOverridable
    ({ google-api-python-client, pythonPackages  }:
      with {
        got  = pythonPackages.oauth2client.version;
        want = "1.4.12";
      };
      assert compareVersions got want < 1 || die {
        inherit got want;
        error = "oauth2client version should be <= ${want}";
      };
      pythonPackages.buildPythonPackage {
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
          google-api-python-client
        ];
      })
      { inherit google-api-python-client pythonPackages; };

  tests = hasBinary pkg "gcalcli";
}
