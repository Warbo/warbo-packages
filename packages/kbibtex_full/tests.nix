{ hasBinary, kbibtex_full, stdenv }:

if stdenv.isDarwin
   then {}
   else hasBinary kbibtex_full "kbibtex"
