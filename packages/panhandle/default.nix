{
  panhandleArgs ? { },
}:
import (fetchGit {
  url = "http://chriswarbo.net/git/panhandle.git";
  ref = "master";
  rev = "e0272b0b9645f09c89589e63002f038e66abfdf4";
}) panhandleArgs
