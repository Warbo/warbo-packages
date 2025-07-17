{ cmake, libsForQt5, runCommand, skulpture, stdenv, writeText }:

with rec {
  inherit (libsForQt5.qt5) qtbase qttools wrapQtAppsHook;
  skulpture-package = skulpture.qt5.override { enableSkulptureGui = true; };
};
stdenv.mkDerivation {
  pname = "kstyle-skulpture-config";
  version = "1.0";

  src = runCommand "skulpture-config-src" {} ''
    mkdir "$out"
    sed -e 's@$'"{skulpture-package}"'@${skulpture-package}@g' \
      < ${./main.cpp} > "$out/main.cpp"
    cp ${./CMakeLists.txt} "$out/CMakeLists.txt"
  '';

  nativeBuildInputs = [
    cmake
    qttools
    wrapQtAppsHook
  ];

  buildInputs = [
    qtbase
    qttools
    skulpture-package
  ];

  buildPhase = ''
    cmake .
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp kstyle-skulpture-config $out/bin/
  '';
}
