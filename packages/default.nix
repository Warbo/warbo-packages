{ fetchGitIPFS ? null
, nix-helpers ? null
, nix-helpers-tree ? { sha1 = "433f580482ca3b2fcae0aa45bc5c79cb59a539d7"; }
, nixpkgs ? null
, nixpkgs-lib ? null
}:
with rec {
  inherit (builtins)
    currentSystem derivation fetchTree getEnv pathExists removeAttrs;
  inherit (resolved.nixpkgs-lib) mapAttrs;
  inherit (resolved.nix-helpers) nixDirsIn nixFilesIn;

  fetch =
    if fetchGitIPFS == null
    then (f: if nixpkgs == null
             then f
             else (f { pkgs = nixpkgs; }).fetchGitIPFS)
      (import ../util/fetchGitIPFS.nix)
    else fetchGitIPFS;

  resolved = {
    nixpkgs = if nixpkgs == null then resolved.nix-helpers.nixpkgs else nixpkgs;
    nixpkgs-lib = if nixpkgs-lib == null
                  then resolved.nix-helpers.nixpkgs-lib
                  else nixpkgs-lib;
    nix-helpers =
      if nix-helpers == null
      then import
        (fetch nix-helpers-tree)
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
