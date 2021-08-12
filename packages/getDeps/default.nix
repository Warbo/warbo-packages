{ gitSource, haskell-nix, stdenv }:

if stdenv.isDarwin
   then null
   else (import ./components.nix {
     inherit gitSource haskell-nix;
   }).exes.GetDeps
