{ pidgin, pidgin-privacy-please }:

pidgin.override {
  plugins = builtins.trace
    "FIXME: pidgin-privacy-please seems to be deleted upstream"
    [ /*pidgin-privacy-please*/ ];
}
