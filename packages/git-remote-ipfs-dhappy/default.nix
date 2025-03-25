{ buildGoModule, fetchTreeFromGitHub }:
buildGoModule {
  pname = "git-remote-ipfs";
  version = "0.0.0";
  vendorHash = "sha256-hkenInaS6PFnu/Z0oz32Y4B4BmM5+l5AB2/K1f/LxqA=";
  src = fetchTreeFromGitHub {
    owner = "dhappy";
    repo = "git-remote-ipfs";
    tree = "c66e697de5055c2fd21b995b8f237781b7110c48";
  };
  /*
  Skip tests, as they fail with:

    --- FAIL: TestCapabilities (0.35s)
    panic: runtime error: invalid memory address or nil pointer dereference [recovered]
    panic: runtime error: invalid memory address or nil pointer dereference
    [signal SIGSEGV: segmentation violation code=0x1 addr=0x8 pc=0x8505d6]

  That error is referenced in the project README:

  > This dramatic message likely means the IPFS server isn't running.

  Fair enough, but we don't want our Nix build to require an IPFS implementation
  to be running and accessible. Hence we skip the tests.
  */
  doCheck = false;
}
