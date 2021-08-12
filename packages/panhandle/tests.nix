{ gitSource, stdenv }@args:

(import ./components.nix args).tests or {}
