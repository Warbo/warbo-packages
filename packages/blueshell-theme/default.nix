{
  buildEnv,
  gtk-engine-bluecurve,
  runCommand,
}:
with rec {
  name = "Blueshell";
  src = builtins.fetchGit {
    url = "https://gitlab.com/KlipKyle/Blueshell.git";
    rev = "d1700b7b043e81edd8d9294dd48e3116b8413252";
  };
};
buildEnv {
  name = "blueshell-theme";
  paths = [
    gtk-engine-bluecurve
    (runCommand name { inherit src; } ''
      mkdir -p "$out/share/themes"
      cp -r "$src" "$out/share/themes/Blueshell"
    '')
  ];
}
