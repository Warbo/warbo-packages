{ darwin, fetchFromGitHub, fetchurl, hasBinary, pythonPackages, stdenv }:

with {
  mercurial = pythonPackages.buildPythonPackage {
    name                  = "mercurial";
    # Make sure ApplicationServices/ApplicationServices.h is available
    propagatedBuildInputs =
      if stdenv.isDarwin
         then (with darwin.apple_sdk.frameworks; [
           CoreGraphics
           ApplicationServices
           Carbon
         ])
         else [];
    src  = fetchurl {
      url    = "https://www.mercurial-scm.org/release/mercurial-4.2.1.tar.gz";
      sha256 = "182qh6d0srps2n5sydzy8n3gi78la6m0wi3846zpyyd0b8pmgmfp";
    };
  };
};
rec {
  pkg = pythonPackages.buildPythonPackage {
    name = "artemis";
    src  = fetchFromGitHub {
      owner  = "mrzv";
      repo   = "artemis";
      rev    = "6a3d496";
      sha256 = "1xdd4ayb6jyk4w5hdq2dxbxzzk90lk21rvkhwcih8ydwwg6zrnqh";
    };
    propagatedBuildInputs = [ mercurial ];
  };

  tests = hasBinary pkg "git-artemis";
}
