{ gitSource, stdenv }@args:

(import ./components.nix args).panpipe.components.exes.panpipe or null
