import (
  builtins.fetchGit {
    name = "artemis-src";
    ref = "master";
    rev = "c1d7730f3d26bf352dec3471d7b8a17dd443b3e0";
    url = "http://chriswarbo.net/git/artemis.git";
  }
)
