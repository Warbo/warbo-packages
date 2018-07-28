{ autoconf, automake, fetchFromGitHub, glib, intltool, libtool, nothing, pidgin,
  pkgconfig, stdenv, unpack', useLocal ? true }:

with rec {
  local = unpack' "pidgin-privacy-please"
                  ../util/pidgin-privacy-please_0.7.1.orig.tar.gz;

  upstream = fetchFromGitHub {
    owner  = "cockroach";
    repo   = "pidgin-privacy-please";
    rev    = "8c63bcf";
    sha256 = "1v175x73zhv0xmc202i10kvm0h1cpy55n94wja9dk77g05vhy84y";
  };

  env = if useLocal
           then { src = local; }
           else {
             preConfigure = "./autogen.sh";
             src          = upstream;
           };
};
{
  pkg = stdenv.mkDerivation (env // {
    name         = "pidgin-privacy-please";
    buildInputs  = [ autoconf automake glib intltool libtool pidgin pkgconfig ];
    installPhase = ''
      mkdir -p "$out/lib/pidgin"
      pushd src
        bash ../libtool --silent --mode=install install -c libpidgin_pp.la \
          "$out/lib/pidgin"
      popd
    '';
  });
  tests = {
    localStillNeeded = isBroken upstream;
  };
}
