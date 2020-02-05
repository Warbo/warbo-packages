{ beautifulsoup-custom, fetchurl, fetchFromGitHub, pythonPackages }:

with rec {
  mf2util = pythonPackages.buildPythonPackage {
    name    = "mf2util";
    doCheck = false;
    src     = fetchurl {
      url    = "https://pypi.python.org/packages/6c/54/6ff9c7b888bcc1e61da1a4b8cb5165f977660efb6b2faa5e229b73bd10a3/mf2util-0.4.3.tar.gz";
      sha256 = "0ck7w6iraadyi8399w89qad5knvz24gx36l6qkd4ld9wba69dm2q";
    };
  };

  requests = pythonPackages.buildPythonPackage {
    name    = "requests";
    doCheck = false;
    src     = fetchurl {
      url    = "https://pypi.python.org/packages/2e/ad/e627446492cc374c284e82381215dcd9a0a87c4f6e90e9789afefe6da0ad/requests-2.11.1.tar.gz";
      sha256 = "0cx1w7m4cpslxz9jljxv0l9892ygrrckkiwpp2hangr8b01rikss";
    };
  };
};
{
  pkg = pythonPackages.buildPythonPackage {
    name       = "mf2py";
    version    = "1.0.5";
    __noChroot = true;
    src        = fetchFromGitHub {
      owner  = "tommorris";
      repo   = "mf2py";
      rev    = "c133581";
      sha256 = "1agz7fbpplv719l0hfwflzbsahsyhrx904gf8azy6gxwzay3hf2h";
    };

    propagatedBuildInputs = [
      beautifulsoup-custom
      mf2util
      pythonPackages.html5lib
      pythonPackages.mock
      pythonPackages.nose
      pythonPackages.python
      requests
    ];
  };

  tests = {};
}
