{
  feed2maildirsimple-args ? { },
}:

import (fetchGit {
  name = "feed2maildirsimple";
  url = "http://chriswarbo.net/git/feed2maildir.git";
  ref = "master";
  rev = "0e452fad641119b58390813288687ffc5401463f";
}) feed2maildirsimple-args
