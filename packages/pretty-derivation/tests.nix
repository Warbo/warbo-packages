{ haskell-nix, skipMac }:

skipMac "pretty-derivation tests"
(import ./components.nix { inherit haskell-nix; }).tests
