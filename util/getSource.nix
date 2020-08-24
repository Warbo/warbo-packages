# Pull the given name from niv's sources.nix
{ warbo-packages-sources }:

{ name }: (builtins.getAttr name warbo-packages-sources).outPath
