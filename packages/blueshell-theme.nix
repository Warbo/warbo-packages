{ buildEnv, fetchurl, gtk-engine-bluecurve, runCommand }:

with rec {
  rev  = "d1700b7b043e81edd8d9294dd48e3116b8413252";
  path = "-/archive/${rev}/Blueshell-${rev}.tar.gz";
  src = fetchurl {
    url    = "https://gitlab.com/KlipKyle/Blueshell/${path}";
    sha256 = "1xr7271i57jz5jc12a31vx0f3clvgg8kinqjhvw8g5hdl77d24vg";
  };
  pkg = runCommand "Blueshell" { inherit src; } ''
    mkdir -p "$out/share/themes"
    cp -r "$src" "$out/share/themes/Blueshell"
  '';
};
buildEnv {
  name  = "blueshell-theme";
  paths = [ gtk-engine-bluecurve pkg ];
}
