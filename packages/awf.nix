{ autoconf, automake, fail, fetchFromGitHub, gcc, gtk2, gtk3, hasBinary,
  pkgconfig, runCommand, stdenv, stripOverrides, widgetThemes ? {} }:

with builtins;
with rec {
  whole = stdenv.mkDerivation rec {
    name         = "awf";
    src          = getSource { inherit name; };
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
