{ getSource, stdenv }:

stdenv.mkDerivation rec {
  name         = "font-spacemono";
  src          = getSource { inherit name; };
  buildCommand = ''
    source $stdenv/setup

    mkdir -p "$out/share"
    cp -r "$src/fonts" "$out/share"
  '';
}
