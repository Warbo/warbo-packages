with builtins;
with import (import ./nix/sources.nix {}).nix-helpers.outPath;
with import ./.;
removeAttrs warbo-packages [
  "haskell"
  "haskellPackages"
  "warbo-packages"
]
