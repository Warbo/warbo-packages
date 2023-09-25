{ panhandleArgs ? { } }:
import (fetchGit {
  url = "http://chriswarbo.net/git/panhandle.git";
  ref = "master";
  rev = "6b3d4755b1ac4125ea12d07f80cd6d3241904b17";
}) panhandleArgs
