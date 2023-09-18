{ panhandleArgs ? { } }:
import (fetchGit {
  url = "http://chriswarbo.net/git/panhandle.git";
  ref = "master";
  rev = "7b207ea0513552bdd78cbd6efcd1cb82e8d4dd64";
}) panhandleArgs
