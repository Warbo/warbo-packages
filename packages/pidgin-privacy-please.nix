{ autoconf, automake, dummyBuild, fetchFromGitHub, glib, intltool, isBroken,
  lib, libtool, overrideGstreamer ? true, pidgin, pkgconfig, stdenv, unfix,
  unpack', useLocal ? true }:

with builtins;
with lib;
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

  # v4l-util is broken on Nixpkgs 19.09, but we don't need it for this build
  pidginWithoutGstreamer = (pidgin.override (old: {
    farstream = dummyBuild "farstream-dummy";
    gst_all_1 = {
      gst-plugins-base = dummyBuild "gst-plugins-base-dummy" // {
        dev = dummyBuild "gst-plugins-good-dev-dummy";
      };
      gst-plugins-good = dummyBuild "gst-plugins-good-dummy";
      gstreamer        = dummyBuild "gstreamer";
    };
  })).overrideAttrs (old: {
    configureFlags = (old.configureFlags or []) ++ [
      "--disable-gstreamer"
      "--disable-vv"
    ];
  });
};
{
  pkg = stdenv.mkDerivation (env // {
    name        = "pidgin-privacy-please";
    buildInputs = [ autoconf automake glib intltool libtool pkgconfig ] ++
      (if overrideGstreamer then [ pidginWithoutGstreamer ] else [ pidgin ]);
    installPhase = ''
      mkdir -p "$out/lib/pidgin"
      pushd src
        bash ../libtool --silent --mode=install install -c libpidgin_pp.la \
          "$out/lib/pidgin"
      popd
    '';
  });
  tests = {
    # Check that upstream is still missing (otherwise we'd prefer to use it).
    # We need 'unfix' to strip the hashes, since 'isBroken' changes them.
    localStillNeeded = unfix (isBroken upstream);
  };
}
