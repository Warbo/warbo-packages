{ gitSource }:

(import ./components.nix { inherit gitSource; }).exes.panhandle
