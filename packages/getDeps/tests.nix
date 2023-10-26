{ gitSource, haskell-nix, skipMac }:

skipMac "getDeps tests"
(import ./components.nix { inherit gitSource haskell-nix; }).tests
