self: super: helf: huper:

huper.panpipe or (helf.callPackage (self.haskellGit {
  url    = "${self.repoSource or self.defaultRepo}/panpipe.git";
  stable = {
    rev        = "7b8aba6";
    sha256     = "0m5f9j1474f9w8mi2n93df9yzfycavagj1b1kkxcxb6c7j4dxidl";
    unsafeSkip = false;
  };
}) {})
