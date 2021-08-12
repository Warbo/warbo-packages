{ gitSource, skipMac }:

skipMac "panpipe tests"
  (import ./components.nix { inherit gitSource; }).panpipe.components.tests
