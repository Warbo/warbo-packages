{ forceLatest ? false, hasBinary, latestGit, stdenv }:

rec {
  pkg = stdenv.mkDerivation {
    name = "git2html";

    src = latestGit {
      url = https://github.com/Hypercubed/git2html.git;
      stable = {
        rev        = "b29cc95";
        sha256     = "0aifz2mdkxay40x2mimx6jz964jb16x4nvbyifkgkxb1jx7fr4jb";
        unsafeSkip = forceLatest;
      };
    };

    installPhase = ''
      mkdir -p "$out/bin"
      cp git2html.sh "$out/bin/git2html"
    '';
  };

  tests = hasBinary pkg "git2html";
}
