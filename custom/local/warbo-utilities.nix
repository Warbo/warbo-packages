{ repoSource, self, stable, withLatestGit }:

withLatestGit {
  url      = "${repoSource}/warbo-utilities.git";
  srcToPkg = src: import "${src}" (if stable
                                      then {}
                                      else { nixPkgs = self; });
  stable   = {
    rev    = "004f327";
    sha256 = "1dhyhr6vph84x35wckibnfmlmbz6fwb2lb3m9hs367al0lzgxbpz";
  };
}
