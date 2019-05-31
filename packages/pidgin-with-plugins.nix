{ pidgin, pidgin-otr, pidgin-privacy-please }:

{
  pkg = pidgin.override {
    plugins = [ pidgin-privacy-please pidgin-otr ];
  };

  tests = {};
}
