{ nix-helpers ? null
, nix-helpers-tree ? { sha1 = "433f580482ca3b2fcae0aa45bc5c79cb59a539d7"; }
, nixpkgs ? null
, nixpkgs-lib ? null
}:
with rec {
  inherit (builtins)
    currentSystem derivation fetchTree getEnv pathExists removeAttrs;
  inherit (resolved.nixpkgs-lib) mapAttrs;
  inherit (resolved.nix-helpers) nixDirsIn nixFilesIn;

  fetchGitIPFS =
    with rec {
      # The version of fetchGitIPFS.nix. Shouldn't need updating often.
      cid = "bafkreihec2oflgbudu5ncpttdyqsjcc74hs4k26b6absfdmqopqogajhj4";
      narHash = "sha256-CgpPlgMjIt3DYVTJYmpdm/V5626f2s5lrEMtGEYQzTU=";

      # fetchTree only takes one URL, so allow it to be overridden by env var.
      override = getEnv "IPFS_GATEWAY";
      gateway = if override == "" then "https://ipfs.io" else override;

      # Workaround for https://github.com/NixOS/nix/issues/12751
      # A derivation which copies 'src'. Since it's fixed-output, the resulting
      # 'outPath' is independent of 'src' (it only depends on 'narHash').
      fixed = src: derivation {
        name = "source";
        builder = "/bin/sh";
        system = currentSystem;
        outputHashMode = "nar";
        outputHash = narHash;
        args = [
          "-c"
          ''read -r -d "" content < ${src}; printf '%s\n' "$content" > "$out"''
        ];
      };
      # See if we already have an outPath for this narHash, by checking with a
      # dummy src: if so, use that path; otherwise call 'fetchTree'.
      existing = (fixed "/dev/null").outPath;
      file = if pathExists existing then existing else fixed (fetchTree {
        inherit narHash;
        type = "file";
        url = "${gateway}/ipfs/${cid}";
      });

      raw = import file;
    };
    if nixpkgs == null then raw else (raw { pkgs = nixpkgs; }).fetchGitIPFS;

  resolved = {
    nixpkgs = if nixpkgs == null then resolved.nix-helpers.nixpkgs else nixpkgs;
    nixpkgs-lib = if nixpkgs-lib == null
                  then resolved.nix-helpers.nixpkgs-lib
                  else nixpkgs-lib;
    nix-helpers =
      if nix-helpers == null
      then import
        (fetchGitIPFS nix-helpers-tree)
        ((if nixpkgs == null then {} else { inherit nixpkgs; }) //
         (if nixpkgs-lib == null then {} else { inherit nixpkgs-lib; }))
      else nix-helpers;
  };

  util = mapAttrs call (nixFilesIn ../util);

  # Like callPackage, but allows args to come from extraArgs
  call = _: f: resolved.nixpkgs.newScope extraArgs f { };

  # Include warbo-packages, so packages can reference each other. Put it first,
  # so that later attrsets will be checked first (making circular references
  # less likely)
  extraArgs =
    warbo-packages
    // resolved.nix-helpers
    // util
    // resolved
    # Useful for overriding things
    // { inherit extraArgs; };

  load =
    filename:
    mapAttrs call (nixDirsIn {
      inherit filename;
      dir = ./.;
    });

  packages = load "default.nix";
  tests = load "tests.nix";

  warbo-packages = packages // {
    inherit warbo-packages;
    warbo-packages-tests = tests;
  };
};
warbo-packages
