# Pretty-printer for Nix .drv files
{ haskell-nix }:

(import ./components.nix { inherit haskell-nix; }).exes.pretty-derivation
