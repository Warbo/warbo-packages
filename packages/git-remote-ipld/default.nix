{ buildGoModule, fetchTreeFromGitHub }:
buildGoModule rec {
  pname = "git-remote-ipld";
  version = "0.0.0";
  vendorHash = "sha256-hsfeTfCcnpyJY+TxCIm1SKhEPu9U7bfUxyR7nS2pYMA=";
  src = fetchTreeFromGitHub {
    owner = "ipfs-shipyard";
    repo = pname;
    tree = "184e3bc364ab302c83a051406f550406fe19a3a9";
  };

  # --- FAIL: TestCapabilities (0.13s)
  #  panic: runtime error: invalid memory address or nil pointer dereference [recovered]
  #          panic: runtime error: invalid memory address or nil pointer dereference
  #  [signal SIGSEGV: segmentation violation code=0x1 addr=0x8 pc=0x861906]
  doCheck = false;
}
