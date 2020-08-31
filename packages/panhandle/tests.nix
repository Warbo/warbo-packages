{ gitSource }:

(import ./components.nix { inherit getSource; }).tests
