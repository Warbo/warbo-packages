{ haskell-nix, stdenv }:

if stdenv.isDarwin
   then {}
   else (import ./components.nix { inherit haskell-nix; }).tests
