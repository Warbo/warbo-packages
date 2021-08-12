{ gitSource, haskell-nix, stdenv }:

if stdenv.isDarwin
   then {}
   else (import ./components.nix {
     inherit gitSource haskell-nix;
   }).tests
