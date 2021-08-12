{ gitSource, skipMac }:

skipMac "panhandle tests" (import ./components.nix { inherit gitSource;}).tests
