{ gitSource }:

(import ./components.nix { inherit gitSource; }).panpipe.components.exes.panpipe
