{ gitSource, haskell-nix, skipMac }:

skipMac "getDeps" (import ./components.nix {
  inherit gitSource haskell-nix;
}).exes.GetDeps
