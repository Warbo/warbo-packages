{
  autoconf,
  automake,
  fail,
  gcc,
  getSource,
  gtk2,
  gtk3,
  pkgconfig,
  runCommand,
  stdenv,
  stripOverrides,
  widgetThemes ? { },
}:

stdenv.mkDerivation rec {
  name = "awf";
  src = getSource { inherit name; };
  buildInputs = [
    autoconf
    automake
    gcc
    gtk2
    gtk3
    pkgconfig
  ] ++ builtins.attrValues (stripOverrides widgetThemes);
  preConfigure = "bash autogen.sh";

  meta = {
    priority = 10; # Avoid icon conflicts
  };
}
