{ gitSource }:

with {
  src  = gitSource { name = "panhandle"; };
};
import "${src}/release.nix"
