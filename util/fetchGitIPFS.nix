with rec {
  inherit (builtins)
    convertHash
    getEnv
    ;

  # The version of fetchGitIPFS.nix. Shouldn't need updating often.
  hash = "sha256-otICYs6b6VGtAVUhC/j+oHq7QboWxasJqUjZDTO3m6M=";
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
