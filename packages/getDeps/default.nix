{ gitSource, haskell-nix }:

(import ./components.nix { inherit gitSource haskell-nix; }).exes.GetDeps
