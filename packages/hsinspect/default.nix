{ getSource, haskell-nix, repo1909, skipMac }:

skipMac "hsinspect" (import ./components.nix {
  inherit getSource haskell-nix repo1909;
}).exes.hsinspect
