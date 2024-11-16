{
  buildEnv,
  imake,
  stdenv,
  xorg,
}:
with {
  tools = buildEnv {
    name = "font-tools";
    paths = [
      xorg.bdftopcf
      xorg.mkfontdir
    ];
  };
};
stdenv.mkDerivation {
  name = "jmk-x11-fonts";
  src = fetchGit {
    url = "https://github.com/nikolas/jmk-x11-fonts.git";
    rev = "29ae539d18005b9f9a863870cd181f208f08181b";
  };
  makeFlags = [ "XBINDIR=${tools}/bin" ];
  buildInputs = [ imake ];
  preInstall = ''
    makeFlags="$makeFlags FONTDIR=$out/share/X11/fonts"
    export makeFlags
  '';
}
