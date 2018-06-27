# Override forceLatest to get the latest version
{ defaultRepo, forceLatest ? false, latestGit, pkgHasBinary,
  repoSource ? defaultRepo }:

with {
  pkg = import (latestGit {
    url    = "${repoSource}/warbo-utilities.git";
    stable = {
      rev        = "e806837";
      sha256     = "05g1kqaqymnnnfxx516jilz5a9salhv5ggcppfi0bbmmd7i1jy8g";
      unsafeSkip = forceLatest;
    };
  });
};

pkgHasBinary "jo" pkg
