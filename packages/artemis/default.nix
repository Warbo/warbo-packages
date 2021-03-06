{ darwin, getSource, pythonPackages, stdenv }:

with {
  mercurial = pythonPackages.buildPythonPackage rec {
    name = "mercurial";
    src  = getSource { inherit name; };

    # Make sure ApplicationServices/ApplicationServices.h is available
    propagatedBuildInputs =
      if stdenv.isDarwin
         then (with darwin.apple_sdk.frameworks; [
           CoreGraphics
           ApplicationServices
           Carbon
         ])
         else [];
  };
};
pythonPackages.buildPythonPackage rec {
  name                  = "artemis";
  src                   = getSource { inherit name; };
  propagatedBuildInputs = [ mercurial ];
}
