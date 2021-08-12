{ haskell-nix, skipMac }:

skipMac "shellcheck tests"
  (import ./components.nix { inherit haskell-nix; }).tests
