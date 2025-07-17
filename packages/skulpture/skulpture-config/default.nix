{ cmake, libsForQt5, runCommand, skulpture, stdenv, writeText }:

with rec {
  inherit (libsForQt5.qt5) qtbase qttools wrapQtAppsHook;
  skulpture-package = skulpture.qt5.override { enableSkulptureGui = true; };
  maker = writeText "skulpture-config-cmake.txt" ''
    cmake_minimum_required(VERSION 3.16)
    project(kstyle-skulpture-config)

    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)

    find_package(Qt5 REQUIRED COMPONENTS Core Widgets)

    set(CMAKE_AUTOMOC ON)

    add_executable(kstyle-skulpture-config main.cpp)
    target_link_libraries(kstyle-skulpture-config Qt5::Core Qt5::Widgets)

    install(TARGETS kstyle-skulpture-config DESTINATION bin)
  '';

  main = runCommand "main.cpp" { raw = ./main.cpp; } ''
    sed -e 's@$'"{skulpture-package}"'@${skulpture-package}@g' < "$raw" > "$out"
  '';
};
stdenv.mkDerivation {
  pname = "kstyle-skulpture-config";
  version = "1.0";

  src = runCommand "skulpture-config-src" { inherit main maker; } ''
    mkdir "$out"
    cp "$main" "$out/main.cpp"
    cp "$maker" "$out/CMakeLists.txt"
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
