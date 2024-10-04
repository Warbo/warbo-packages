{ lib, buildNpmPackage }:
with {
  src = builtins.fetchGit {
    url = "https://github.com/NicolasPetton/Indium.git";
    rev = "8499e156bf7286846c3a2bf8c9e0c4d4f24b224c";
  };
};
buildNpmPackage {
  pname = "indium";
  version = src.rev;
  src = "${src}/server";
  npmDepsHash = "sha256-LCaH/NzX6VNyJQl16jvfhPO8/VJxOMKEBmZlbG+2nQY=";
  dontNpmBuild = true;
  makeCacheWritable = true;
  meta = with lib; {
    description = "Server component for Emacs JavaScript dev environment";
    homepage = "https://github.com/NicolasPetton/Indium.git";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ ];
  };
}
