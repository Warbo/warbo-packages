{
  fetchurl,
  fluidsynth,
  libpng,
  libvorbis,
  lua,
  pkgconfig,
  SDL,
  SDL_mixer,
  SDL_ttf,
  stdenv,
  zlib,
}:

# FIXME: Replace with https://gitlab.com/domino-chain
stdenv.mkDerivation {
  name = "pushover";
  src = fetchurl {
    url = "mirror://sourceforge/pushover/pushover-0.0.5.tar.gz";
    sha256 = "1l06ish46xy5sflzls6m6md9ln9sh4dqnsskry8fmr32gb24xsih";
  };
  buildInputs = [
    fluidsynth
    libpng
    libvorbis
    lua
    pkgconfig
    SDL
    SDL_mixer
    SDL_ttf
    zlib
  ];
}
