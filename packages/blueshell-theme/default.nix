{ buildEnv, getSource, gtk-engine-bluecurve, runCommand, stdenv }:

with rec {
  name = "Blueshell";
  src  = runCommand name
    { src = getSource { inherit name; }; }
    ''
      mkdir -p "$out/share/themes"
      cp -r "$src" "$out/share/themes/Blueshell"
    '';
};
if stdenv.isDarwin
   then null
   else buildEnv {
     name  = "blueshell-theme";
     paths = [ gtk-engine-bluecurve src ];
   }
