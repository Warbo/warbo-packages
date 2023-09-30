# Take pythonPackages from Nixpkgs 20.03 to avoid end-of-life errors in newer
# releases.
{ darwin, getSource, nixpkgs2003, stdenv }:

with rec {
  inherit (nixpkgs2003) pythonPackages;

  mercurial = pythonPackages.buildPythonPackage rec {
    name = "mercurial";
    src = getSource { inherit name; };

    # Make sure ApplicationServices/ApplicationServices.h is available
    propagatedBuildInputs = if stdenv.isDarwin then
      (with darwin.apple_sdk.frameworks; [
        CoreGraphics
        ApplicationServices
        Carbon
      ])
    else
      [ ];
  };
};
pythonPackages.buildPythonPackage rec {
  name = "artemis";
  src = getSource { inherit name; };
  propagatedBuildInputs = [ mercurial ];
}
