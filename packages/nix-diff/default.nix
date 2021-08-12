{ haskell-nix, skipMac }:

skipMac "nix-diff"
  (import ./components.nix { inherit haskell-nix; }).exes.nix-diff
