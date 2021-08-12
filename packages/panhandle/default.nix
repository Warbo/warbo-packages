{ gitSource, skipMac }:

skipMac "panhandle" (import ./components.nix {
  inherit gitSource;
}).exes.panhandle
