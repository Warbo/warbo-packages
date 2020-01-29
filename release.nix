with builtins;
with import (import ./helpers.nix {}).nix-helpers;
with import ./.;
removeAttrs warbo-packages [
  "haskell"
  "haskellPackages"
  "warbo-packages"
]
