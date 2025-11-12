{
  getSource,
  gtk2,
  pkg-config,
  runCommand,
  stdenv,
}:

with rec {
  name = "gtk-aurora-engine";
  repo = getSource { inherit name; };
};
runCommand "aurora-engine"
  {
    engine = stdenv.mkDerivation {
      inherit name;
      src = "${repo}/aurora-1.5";
      buildInputs = [
        gtk2
        pkg-config
      ];
    };

    theme = "${repo}/Aurora";
  }
  ''
    cp -r "$engine" "$out"
    chmod +w -R "$out"
    mkdir -p "$out/share/themes"
    cp -r "$theme" "$out/share/themes/Aurora"
  ''
