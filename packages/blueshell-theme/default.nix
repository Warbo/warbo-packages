{ buildEnv, getSource, gtk-engine-bluecurve, runCommand, skipMac }:

with rec {
  name = "Blueshell";
  src  = runCommand name
    { src = getSource { inherit name; }; }
    ''
      mkdir -p "$out/share/themes"
      cp -r "$src" "$out/share/themes/Blueshell"
    '';
};
skipMac "blueshell-theme" (buildEnv {
  name  = "blueshell-theme";
  paths = [ gtk-engine-bluecurve src ];
})
