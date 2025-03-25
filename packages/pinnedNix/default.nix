{
  fetchTreeFromGitHub,
  system ? builtins.currentSystem,
  tree ? "d98be1c493843ab5ab00d8e4bb37e56a10bdbc77",
  nix-source ? fetchTreeFromGitHub {
    inherit tree;
    owner = "NixOS";
    repo = "nix";
  },
}:
(builtins.getAttr system (import nix-source).packages).default
