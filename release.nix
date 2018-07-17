with builtins;
with import (import ./helpers.nix {});
with import ./.;
collapseAttrs (removeAttrs warbo-packages [
  "haskell"
  "haskellPackages"
  "warbo-packages"
])
