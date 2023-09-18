{ fetchFromGitHub, system ? builtins.currentSystem
, rev ? "2da46530d0bb4faf8ca0605f8fdffca7bd5baa73"
, hash ? "sha256-fstL4alQM8QpsunEtaErpURwQ0yoTh19YdjobsN2ids=", nix-source ?
  fetchFromGitHub {
    inherit hash rev;
    owner = "NixOS";
    repo = "nix";
  } }:
(builtins.getAttr system (import nix-source).packages).default
