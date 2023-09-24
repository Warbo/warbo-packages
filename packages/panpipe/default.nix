{ panpipeArgs ? { }, panpipeRev ? "4a7ad10fac3517464b9edc89891c381bd534d90a" }:

import (fetchGit {
  url = "http://chriswarbo.net/git/panpipe.git";
  ref = "master";
  rev = panpipeRev;
}) panpipeArgs
