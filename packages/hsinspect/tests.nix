{ getSource, haskell-nix, repo1909, stdenv }:

if stdenv.isDarwin
   then null
   else (import ./components.nix {
     inherit getSource haskell-nix repo1909;
   }).tests
