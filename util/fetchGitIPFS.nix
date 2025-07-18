with rec {
  inherit (builtins)
    currentSystem
    derivation
    fetchTree
    getEnv
    pathExists
    ;

  # The version of fetchGitIPFS.nix. Shouldn't need updating often.
  cid = "bafkreihec2oflgbudu5ncpttdyqsjcc74hs4k26b6absfdmqopqogajhj4";
  narHash = "sha256-CgpPlgMjIt3DYVTJYmpdm/V5626f2s5lrEMtGEYQzTU=";

  # fetchTree only takes one URL, so allow it to be overridden by env var.
  override = getEnv "IPFS_GATEWAY";
  gateway = if override == "" then "https://ipfs.io" else override;

  # Workaround for https://github.com/NixOS/nix/issues/12751 A derivation
  # which copies 'src'. Since it's fixed-output, the resulting 'outPath'
  # is independent of 'src' (it only depends on 'narHash').
  fixed =
    f:
    derivation {
      name = "source";
      builder = "/bin/sh";
      system = currentSystem;
      outputHashMode = "nar";
      outputHash = narHash;
      args = [
        "-c"
        ''read -r -d "" content < ${f}; printf '%s\n' "$content" > "$out"''
      ];
    };
  # See if we already have an outPath for this narHash, by checking with a
  # dummy src: if so, use that path; otherwise call 'fetchTree'.
  existing = (fixed "/dev/null").outPath;
  file =
    if pathExists existing then
      existing
    else
      fixed (fetchTree {
        inherit narHash;
        type = "file";
        url = "${gateway}/ipfs/${cid}";
      });
};
import file
