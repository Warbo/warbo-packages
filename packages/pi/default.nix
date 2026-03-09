{
  callPackage,
  emptyDirectory,
  fetchTreeFromGitHub,
}:
with rec {
  numtide-llms = fetchTreeFromGitHub {
    owner = "numtide";
    repo = "llm-agents.nix";
    tree = "59ec50a7257c2dd9858ec5c30b543b47c8718547";
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
