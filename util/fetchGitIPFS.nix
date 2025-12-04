with rec {
  inherit (builtins)
    convertHash
    getEnv
    ;

  # The version of fetchGitIPFS.nix. Shouldn't need updating often.
  hash = "sha256-Cd+/MvPeFksqi4uZ9SaeHEIHKQH0UJTcl6w65TIw3WA=";
  cid = "f01551220${
    convertHash {
      inherit hash;
      hashAlgo = "sha256";
      toHashFormat = "base16";
    }
  }";

  # fetchurl only takes one URL, so allow it to be overridden by env var.
  override = getEnv "IPFS_GATEWAY";
  gateway = if override == "" then "https://ipfs.io" else override;

  file = import <nix/fetchurl.nix> {
    inherit hash;
    url = "${gateway}/ipfs/${cid}";
  };
};
import file
