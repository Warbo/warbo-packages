{
  callPackage,
  emptyDirectory,
  fetchTreeFromGitHub,
}:
with rec {
  numtide-llms = fetchTreeFromGitHub {
    owner = "numtide";
    repo = "llm-agents.nix";
    tree = "6b212b41603756a1f2a802a5af989d1b11ac9aa7";
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
