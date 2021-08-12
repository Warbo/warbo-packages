{ haskell-nix, stdenv }:

if stdenv.isDarwin
   then null
   else (import ./components.nix { inherit haskell-nix; }).exes.nix-diff
