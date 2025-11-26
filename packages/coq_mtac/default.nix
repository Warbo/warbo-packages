{
  getSource,
  lib,
  nixpkgs1609,
  skipARM,
}:

skipARM "coq-mtac" (
  lib.overrideDerivation nixpkgs1609.coq (_: rec {
    name = "coq-mtac";
    src = getSource { inherit name; };
  })
)
