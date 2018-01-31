# This contains the stuff we expect to be available for non-interactive scripts
{ self }:

with self;

buildEnv {
  name  = "basic";
  paths = [
    autossh
    artemis
    binutils
    cabal2nix
    dtach
    dvtm
    entr
    exfat
    file
    get_iplayer
    ghc
    ghostscript
    git
    gnumake
    gnutls
    haskellPackages.cabal-install
    haskellPackages.happy
    haskellPackages.hlint
    haskellPackages.pretty-show
    haskellPackages.stylish-haskell
    inotify-tools
    jq
    md2pdf
    msmtp
    nix-repl
    nixpkgs1709.youtube-dl
    openssh
    opusTools
    p7zip
    pamixer
    pandocPkgs
    poppler_utils
    pmutils
    pptp
    psmisc
    python
    nixpkgs1609.racket
    cifs_utils
    silver-searcher
    sshfsFuse
    sshuttle
    smbnetfs
    sox
    st
    imagemagick
    tightvnc
    ts
    usbutils
    unzip
    warbo-utilities
    wget
    wmname
    xbindkeys
    xcalib
    xcape
    xorg.xmodmap
    xorg.xproto
    zip
  ];
}
