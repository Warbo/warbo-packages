{ checkRacket, nixpkgs1609, super }:

with builtins;
with checkRacket;
rec {
  pkg   = (if racketWorks
              then super
              else trace ''
                WARNING: Taking racket from nixpkgs 16.09, since it's broken on
                i686 for newer versions
              '' nixpkgs1609).racket;
  tests = checkWhetherBroken;
}
