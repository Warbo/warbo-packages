{ getSource, haskell-nix, repo1909, skipMac }:

skipMac "hsinspect tests" (import ./components.nix {
  inherit getSource haskell-nix repo1909;
}).tests
