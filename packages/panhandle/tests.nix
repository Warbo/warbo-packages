{ gitSource }:

(import ./components.nix { inherit gitSource; }).tests
