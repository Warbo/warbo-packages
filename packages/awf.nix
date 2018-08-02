{ autoconf, automake, fail, fetchFromGitHub, gcc, gtk2, gtk3, hasBinary,
  pkgconfig, runCommand, stdenv, stripOverrides, widgetThemes ? {} }:

with builtins;
with rec {
  whole = stdenv.mkDerivation {
    name = "awf";
    src  = fetchFromGitHub {
      owner  = "valr";
      repo   = "awf";
      rev    = "c937f1b";
      sha256 = "0jl2kxwpvf2n8974zzyp69mqhsbjnjcqm39y0jvijvjb1iy8iman";
    };
    buildInputs  = [ autoconf automake gcc gtk2 gtk3 pkgconfig ] ++
                   attrValues (stripOverrides widgetThemes);
    preConfigure = "bash autogen.sh";

    meta = {
      priority = 10;  # Avoid icon conflicts
    };
  };
};

rec {
  pkg   = whole;
  tests = {
    gtk2 = hasBinary pkg "awf-gtk2";
    gtk3 = hasBinary pkg "awf-gtk3";
  };
}
