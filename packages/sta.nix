{ autoconf, automake, forceLatest ? false, hasBinary, latestGit, stdenv }:

rec {
  pkg = stdenv.mkDerivation {
    name = "sta";
    src  = latestGit {
      url    = https://github.com/simonccarter/sta.git;
      stable = {
        rev        = "2aa2a60";
        sha256     = "05804f106nb89yvdd0csvpd5skwvnr9x4qr3maqzaw0qr055mrsk";
        unsafeSkip = forceLatest;
      };
    };

    buildInputs  = [ autoconf automake ];
    preConfigure = "./autogen.sh";
  };

  tests = hasBinary pkg "sta";
}
