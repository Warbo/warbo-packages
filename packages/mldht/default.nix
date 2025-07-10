{ jdk, mkMavenPackage, fetchTreeFromGitHub }:
mkMavenPackage rec {
  pname = "mldht";
  version = "0.1.1-SNAPSHOT";
  depsHash = "sha256-SUXDIjsXmLiNweAib4b/eYa6SKZMpsIQ2c/IMJqDKzo=";
  mvnCommands = [
    "package"
    "dependency:copy-dependencies"
    "appassembler:assemble"
  ];
  extraMvnArgs = [ "-DskipTests" ];
  src = fetchTreeFromGitHub {
    owner = "the8472";
    repo = "mldht";
    tree = "3cdc9ae1153e77910e701e43bb8279fee8951672";
  };
  installSteps = [
    ''cp -r bin "$out"''
    ''sed -i -e "s@java@${jdk}/bin/java@g" "$out/bin/mldht-daemon"''
    ''sed -i -e 's@& ) &$@ )@g' "$out/bin/mldht-daemon"''
    ''mkdir "$out/target"''
    ''cp -r target/dependency "$out/target/"''
    ''cp ./target/libmldht*.jar "$out/target/"''
  ] ++ map
    (pattern: ''sed -i -e "s/${pattern}//g" "$out/bin/mldht-daemon"'')
    [
      # Remove some old JVM options that no longer exist
      ''-XX:.UseConcMarkSweepGC''
      ''-XX:.UseParNewGC''
      ''-XX:CMSInitiatingOccupancyFraction=[0-9]*''
      ''-XX:.UseCMSInitiatingOccupancyOnly''
      ''-XX:.PrintGCDateStamps''
      ''-XX:.PrintGCTimeStamps''
      ''-XX:.AggressiveOpts''
    ];
}
