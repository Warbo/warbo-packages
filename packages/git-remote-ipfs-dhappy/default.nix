{ buildGoModule, fetchFromGitHub }:
buildGoModule {
  pname = "git-remote-ipfs";
  version = "0.0.0";
  vendorHash = "sha256-hkenInaS6PFnu/Z0oz32Y4B4BmM5+l5AB2/K1f/LxqA=";
  src = fetchFromGitHub {
    owner = "dhappy";
    repo = "git-remote-ipfs";
    rev = "53f6ecd2e57b074e784c60c5d4b9100757e65b00";
    hash = "sha256-Vzn5QQegAVR4Rmx8bc/fuXZJeNCM1ndRgtmkiEffJ1g=";
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
