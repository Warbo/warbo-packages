{ autoconf, automake, fetchFromGitHub, glib, intltool, libtool, nothing, pidgin,
  pkgconfig, stdenv }:

with {
  real = stdenv.mkDerivation {
    name         = "pidgin-privacy-please";
    buildInputs  = [ autoconf automake glib intltool libtool pidgin pkgconfig ];
    preConfigure = "./autogen.sh";
    src          = fetchFromGitHub {
      owner  = "cockroach";
      repo   = "pidgin-privacy-please";
      rev    = "8c63bcf";
      sha256 = "1v175x73zhv0xmc202i10kvm0h1cpy55n94wja9dk77g05vhy84y";
    };
    installPhase = ''
      mkdir -p "$out/lib/pidgin"
      pushd src
        bash ../libtool --silent --mode=install install -c libpidgin_pp.la \
          "$out/lib/pidgin"
      popd
    '';
  };
};
{
  pkg   = builtins.trace
            "FIXME: pidgin-privacy-please seems to be deleted upstream"
            nothing;
  tests = {};
}
