{
  fetchurl,
  jdk_headless,
  runCommand,
  unzip,
  writeShellApplication,
}:
with rec {
  pname = "clj-opengrok";
  version = "1.7.42";
  bin =
    runCommand "${pname}-${version}"
      {
        buildInputs = [ unzip ];
        zipped = fetchurl {
          url =
            "https://github.com/youngker/${pname}"
            + "/releases/download/${version}/${pname}.zip";
          hash = "sha256-O+JqfskfJlygpgq7Pt7TAK4eMDNbxSuvwac2uncXAfg=";
        };
      }
      ''
        unzip "$zipped"
        mv ${pname} "$out"
      '';
};
writeShellApplication {
  name = pname;
  runtimeInputs = [ jdk_headless ];
  text = ''
    exec ${bin} "$@"
  '';
}
