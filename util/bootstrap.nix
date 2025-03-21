with {
  gateway =
    with { override = builtins.getEnv "IPFS_GATEWAY"; };
    if override == "" then "https://ipfs.io" else override;

  sha1.nix-helpers = "2dd0096d653c5494eb7a4db8135473b330cdfeb8";
};
with {
  fetchGitIPFS = import (builtins.fetchTree {
    type = "file";
    url = "${gateway}/ipfs/bafkreihec2oflgbudu5ncpttdyqsjcc74hs4k26b6absfdmqopqogajhj4";
    narHash = "sha256-CgpPlgMjIt3DYVTJYmpdm/V5626f2s5lrEMtGEYQzTU=";
  });

  mkPkgs = { fetchGitIPFS }:
    with { inherit (fetchGitIPFS { inherit sha1; }) nix-helpers; };
    (import nix-helpers {}).nixpkgs;
};
fetchGitIPFS { inherit mkPkgs sha1; }
