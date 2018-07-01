{ callPackage, hasBinary, repo1609 }:

rec {
  pkg = callPackage "${repo1609}/pkgs/applications/networking/browsers/conkeror"
                    {};

  tests = hasBinary pkg "conkeror";
}
