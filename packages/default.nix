{
  fetchGitIPFS ? null,
  nix-helpers ? null,
  nix-helpers-tree ? {
    # git-ref: pkipfs::yhqn1j1d7i5xb7456639i4uw1e5deeuddjsnyrow46zuxipwgijo master^{tree}
    sha1 = "19264ec494c40c1c6c00945a872b48dee4791692";
  },
  nixpkgs ? null,
  nixpkgs-lib ? null,
}:
with rec {
  inherit (builtins)
    currentSystem
    derivation
    fetchTree
    getEnv
    pathExists
    removeAttrs
    ;
  inherit (resolved.nixpkgs-lib) mapAttrs;
  inherit (resolved.nix-helpers) nixDirsIn nixFilesIn;

  fetch =
    if fetchGitIPFS == null then
      (f: if nixpkgs == null then f else (f { pkgs = nixpkgs; }).fetchGitIPFS) (
        import ../util/fetchGitIPFS.nix
      )
    else
      fetchGitIPFS;

  resolve =
    name: given: if given == null then resolved.nix-helpers.${name} else given;

  resolved = {
    nixpkgs = resolve "nixpkgs" nixpkgs;
    nixpkgs-lib = resolve "nixpkgs-lib" nixpkgs-lib;
    nix-helpers =
      if nix-helpers == null then
        import (fetch nix-helpers-tree) (
          (if nixpkgs == null then { } else { inherit nixpkgs; })
          // (if nixpkgs-lib == null then { } else { inherit nixpkgs-lib; })
        )
      else
        nix-helpers;
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
    // {
      inherit extraArgs;
    };

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
