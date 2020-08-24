{ haskellSrc2nix, gitSource }:

args: haskellSrc2nix {
  inherit (args) name;
  src = gitSource args;
}
