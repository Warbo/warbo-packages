{ dht, fetchTreeFromGitHub, libxcrypt }:

dht.overrideAttrs (old: {
  nativeBuildInputs =
    builtins.filter (p: p.pname != "cmake") old.nativeBuildInputs ++ [
      libxcrypt
    ];

  src = fetchTreeFromGitHub {
    owner = "transmission";
    repo = "dht";
    tree = "626ef045d876bb6a0af7f8c3c3a6b74e4f1d488f";
  };

  installPhase = ''
    mkdir -p "$out/bin"
    cp dht-example "$out/bin/"
  '';
})
