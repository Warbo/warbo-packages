{ gitSource, stdenv }:

if stdenv.isDarwin
   then null
   else import (gitSource { name = "panpipe"; })
