{
  callPackage,
  emptyDirectory,
  fetchTreeFromGitHub,
}:
with rec {
  numtide-llms = fetchTreeFromGitHub {
    owner = "numtide";
    repo = "llm-agents.nix";
    tree = "b80f8ecf734b82cb9ebd7253d0d05be30ad70e50";
  };

  pi = callPackage "${numtide-llms}/packages/pi/package.nix" {
    inherit (callPackage "${numtide-llms}/lib/fetch-npm-deps.nix" { })
      fetchNpmDepsWithPackuments
      npmConfigHook
      ;
    versionCheckHook = emptyDirectory;
    versionCheckHomeHook = emptyDirectory;
  };
};
pi
