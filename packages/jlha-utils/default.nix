{
  fetchTreeFromGitHub,
  fetchurl,
  jre,
  mkMavenPackage,
  writeShellApplication,
}:
with rec {
  jlha = mkMavenPackage {
    pname = "jlha";
    version = "0.06-05";
    jarName = "jlha-0.06-5.jar";
    depsHash = "sha256-ENAiZJAzoX7CGrIRGEAClqaZ42rjyFHoAA0XqSQBAyw=";
    mvnCommands = [ "package" ];
    src = fetchTreeFromGitHub {
      owner = "kclarknz";
      repo = "jLHA";
      tree = "45d436ed2f81b5e89781b540093225ce2fcab92c";
    };
  };

  version = "0.1.6";
  frontend = fetchurl {
    url = "mirror://sourceforge/jlhafrontend/jlhafrontend-${version}.jar";
    sha256 = "sha256-eUGFyfBITjfqeh4T7w+jl3pSAEC+JRJW2FplX9/7rU0=";
  };
};
writeShellApplication {
  name = "jlha";
  runtimeInputs = [ jre ];
  text = ''
    exec java \
      -cp ${jlha}/jlha-0.06-5.jar:${frontend} \
      org.jlhafrontend.JLHAFrontEnd "$@"
  '';
}
