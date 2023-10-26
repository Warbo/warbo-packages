{ getSource, replace, stdenv, xorg }:

stdenv.mkDerivation rec {
  name = "space2ctrl";
  src = getSource { inherit name; };
  buildInputs = [
    replace
    (xorg.inputproto or xorg.xorgproto)
    (xorg.recordproto or xorg.xorgproto)
    xorg.libX11
    xorg.libXext
    xorg.libXi
    xorg.libXtst
    xorg.xinput
  ];

  # Force 'make install' to use $out
  makeFlags = [ "PREFIX=$(out)" ];

  # Avoid triggering a keypress event on startup by commenting out that code
  pre1 = "// TODO: document why the following event is needed";
  post1 = "/*";
  pre2 = "if (!XRecordEnableContext";
  post2 = "*/ if (!XRecordEnableContext";

  preBuild = ''
    replace "$pre1" "$post1" -- Space2Ctrl.cpp
    replace "$pre2" "$post2" -- Space2Ctrl.cpp
  '';
}
