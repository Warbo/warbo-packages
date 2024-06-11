{
  bibtool,
  bibclean,
  curl,
  getSource,
  gnumake,
  poppler_utils,
  stdenv,
  which,
}:

stdenv.mkDerivation rec {
  name = "searchtobibtex";
  src = getSource { inherit name; };

  propagatedBuildInputs = [
    which
    bibtool
    bibclean
    curl
    poppler_utils
  ];

  preConfigure = ''
    sed -i Makefile -e 's@/usr/bin/make@${gnumake}/bin/make@g'
    sed -i Makefile -e "s@/usr/local@$out@g"
  '';
}
