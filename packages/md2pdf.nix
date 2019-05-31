{ defaultRepo, forceLatest ? false, latestGit, repoSource ? defaultRepo,
  stdenv }:

{
  pkg = stdenv.mkDerivation {
    name = "md2pdf";
    src  = latestGit {
      url    = "${repoSource}/md2pdf.git";
      stable = {
        rev        = "ee98157";
        sha256     = "1wrwx4q311ali8ksqdw1dlf4k9hr6m2ycjjjwy1ickmz4fh8gh87";
        unsafeSkip = forceLatest;
      };
    };
    installPhase = ''
      mkdir -p "$out/bin"
      cp md2pdf "$out/bin"
      cp renderWatch "$out/bin"
      chmod +x "$out/bin"/*
    '';
  };
  tests = {};
}
