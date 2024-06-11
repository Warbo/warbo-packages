{
  autoconf,
  automake,
  getSource,
  libXtst,
  libX11,
  libXi,
  libXext,
  libXinerama,
  pkgconfig,
  stdenv,
  xextproto ? null,
  xlibsWrapper,
  xorg,
}:

stdenv.mkDerivation rec {
  name = "x2x";
  src = getSource { inherit name; };

  buildInputs = [
    xlibsWrapper
    autoconf
    automake
    pkgconfig
    libX11
    libXtst
    libXi
    libXext
    libXinerama
    (if xextproto == null then xorg.xorgproto else xextproto)
  ];

  configurePhase = ''
    ./bootstrap.sh
    ./configure --prefix="$out"
  '';
}
