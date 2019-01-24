with builtins;
with import (import ./helpers.nix {}).nix-helpers;
with import ./.;
collapseAttrs (removeAttrs warbo-packages [
  "haskell"
  "haskellPackages"
  "warbo-packages"
])
