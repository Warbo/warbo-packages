{ buildEnv, getSource, gtk-engine-bluecurve, runCommand }:

with rec {
  name = "Blueshell";
  src  = runCommand name
    { src = getSource { inherit name; }; }
    ''
      mkdir -p "$out/share/themes"
      cp -r "$src" "$out/share/themes/Blueshell"
    '';
};
{
  pkg = buildEnv {
    name  = "blueshell-theme";
    paths = [ gtk-engine-bluecurve pkg ];
  };
  tests = {};
}
