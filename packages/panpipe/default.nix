{
  panpipeArgs ? { },
}:

import (fetchGit {
  url = "http://chriswarbo.net/git/panpipe.git";
  ref = "master";
  rev = "19e37791ff36a37117b5715cfd5f1b11471bdfbf";
}) panpipeArgs
