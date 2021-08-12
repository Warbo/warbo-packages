{ gitSource, stdenv }@args:

(import ./components.nix args).panpipe.components.tests or {}
