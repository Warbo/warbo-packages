{ panhandleArgs ? { }, panhandleRev ? "f4447cab557297c5757fbb333eb33a1f8ce87f0d"
}:
import (fetchGit {
  url = "http://chriswarbo.net/git/panhandle.git";
  ref = "master";
  rev = panhandleRev;
}) panhandleArgs
