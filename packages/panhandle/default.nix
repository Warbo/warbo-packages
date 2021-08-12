{ gitSource, stdenv }@args:

(import ./components.nix args).exes.panhandle or null
