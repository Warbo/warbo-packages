# Pretty-printer for Nix .drv files
{ haskell-nix, skipMac }:

skipMac "pretty-derivation"
(import ./components.nix { inherit haskell-nix; }).exes.pretty-derivation
