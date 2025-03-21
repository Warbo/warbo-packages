{ buildGoModule, fetchFromGitHub }:
buildGoModule rec {
  pname = "git-remote-ipld";
  version = "0.0.0";
  vendorHash = "sha256-hsfeTfCcnpyJY+TxCIm1SKhEPu9U7bfUxyR7nS2pYMA=";
  src = fetchFromGitHub {
    owner = "ipfs-shipyard";
    repo = pname;
    rev = "7d3eccfe2d1fb8828ba5599bda4f613747add4cc";
    hash = "sha256-QlAmc6UMrpooXkDFlOBmuWuJF/E7ZCtKOrniz4DxDUc=";
  };

  # --- FAIL: TestCapabilities (0.13s)
  #  panic: runtime error: invalid memory address or nil pointer dereference [recovered]
  #          panic: runtime error: invalid memory address or nil pointer dereference
  #  [signal SIGSEGV: segmentation violation code=0x1 addr=0x8 pc=0x861906]
  doCheck = false;
}
