{
  autoconf,
  automake,
  gcc,
  getSource,
  gtk2,
  gtk3,
  pkg-config,
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
    pkg-config
  ]
  ++ builtins.attrValues (stripOverrides widgetThemes);
  preConfigure = "bash autogen.sh";

  meta = {
    priority = 10; # Avoid icon conflicts
  };
}
