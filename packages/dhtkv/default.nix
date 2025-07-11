{ buildNpmPackage, runCommand }:

buildNpmPackage rec {
  pname = "dhtkv";
  version = "2921e2a64939905d522e4ff44230025ba5769c76";
  dontNpmBuild = true;
  npmDepsHash = "sha256-G9nMckJ/KxutKyJyjItCGYLicM/ri62ec85GWDEm6pA=";
  src =
    runCommand "dhtkv"
      {
        raw = builtins.fetchGit {
          url = "https://github.com/max-mapper/dhtkv.git";
          rev = version;
        };
      }
      ''
        cp -r "$raw" "$out"
        chmod -R +w "$out"
        cp ${./package-lock.json} "$out/package-lock.json"
      '';
}
