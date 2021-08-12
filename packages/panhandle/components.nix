{ gitSource, stdenv }:

with {
  src  = gitSource { name = "panhandle"; };
};
if stdenv.isDarwin
   then null
   else import "${src}/release.nix"
