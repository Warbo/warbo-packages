{ getSource, haskell-nix, repo1909 }:

(import ./components.nix {
  inherit getSource haskell-nix repo1909;
}).exes.hsinspect
