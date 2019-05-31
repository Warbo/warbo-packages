{ autoconf, automake, fetchFromGitHub, hasBinary, libXtst, libX11, libXi,
  libXext, libXinerama, pkgconfig, stdenv, xextproto ? null, xlibsWrapper,
  xorg }:

rec {
  pkg = stdenv.mkDerivation {
    name = "x2x";
    src  = fetchFromGitHub {
      repo   = "x2x";
      owner  = "dottedmag";
      rev    = "89deb1";
      sha256 = "1gcvsfkkf1xhmiv1x9vxgynicw78mvrxiz6a3mgzgyf8b6860d7r";
    };

    buildInputs = [
      xlibsWrapper autoconf automake pkgconfig libX11 libXtst libXi libXext
      libXinerama
      (if xextproto == null
          then xorg.xorgproto
          else xextproto)
    ];

    configurePhase = ''
      ./bootstrap.sh
      ./configure --prefix="$out"
    '';
  };

  tests = hasBinary pkg "x2x";
}
