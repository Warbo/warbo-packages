{ gitSource, stdenv }:

{
  pkg = stdenv.mkDerivation rec {
    name         = "md2pdf";
    src          = gitSource { inherit name; };
    installPhase = ''
      mkdir -p "$out/bin"
      cp md2pdf "$out/bin"
      cp renderWatch "$out/bin"
      chmod +x "$out/bin"/*
    '';
  };
  tests = {};
}
