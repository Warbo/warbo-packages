{ autoconf, automake, dummyBuild, getSource, glib, intltool, isBroken, lib,
  libtool, pidgin, pkgconfig, stdenv, unfix, unpack' }:

with rec {
  # Rename to avoid shadowing
  pidginPristine = pidgin;

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

  makePlugin = {
      overrideGstreamer ? true
    , pidgin            ? if overrideGstreamer
                             then pidginWithoutGstreamer
                             else pidginPristine
    }: stdenv.mkDerivation {
      name = "pidgin-privacy-please";
      src  = unpack' "pidgin-privacy-please"
                     ../util/pidgin-privacy-please_0.7.1.orig.tar.gz;
      buildInputs = [ autoconf automake glib intltool libtool pkgconfig ] ++
        (if overrideGstreamer then [ pidginWithoutGstreamer ] else [ pidgin ]);
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
  pkg   = lib.makeOverridable makePlugin {};
  tests = {};
}
