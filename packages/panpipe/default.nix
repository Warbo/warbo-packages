{ gitSource, skipMac }:

skipMac "panpipe" (import ./components.nix {
  inherit gitSource;
}).panpipe.components.exes.panpipe
