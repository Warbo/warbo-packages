{
  autoconf,
  automake,
  getSource,
  libXtst,
  libX11,
  libXi,
  libXext,
  libXinerama,
  pkg-config,
  stdenv,
  xextproto ? null,
  xorg,
}:

stdenv.mkDerivation rec {
  name = "x2x";
  src = getSource { inherit name; };

  nativeBuildInputs = [
    autoconf
    automake
    pkg-config
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
