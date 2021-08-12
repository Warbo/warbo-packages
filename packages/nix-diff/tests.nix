{ haskell-nix, skipMac }:

skipMac "nix-diff tests"
  (import ./components.nix { inherit haskell-nix; }).tests
