{ nix-helpers ? import ./nix-helpers { }, nixpkgs ? nix-helpers.nixpkgs
, nixpkgs-lib ? nix-helpers.nixpkgs-lib }:

with rec {
  inherit (builtins) removeAttrs;
  inherit (nixpkgs-lib) mapAttrs;
  inherit (nix-helpers) nixDirsIn nixFilesIn;

  util = mapAttrs call (nixFilesIn ../util);

  # Like callPackage, but allows args to come from extraArgs
  call = _: f: nixpkgs.newScope extraArgs f { };

  # Include warbo-packages, so packages can reference each other. Put it first,
  # so that later attrsets will be checked first (making circular references
  # less likely)
  extraArgs = warbo-packages // nix-helpers // util // {
    # Useful for overriding things
    inherit extraArgs nix-helpers nixpkgs;
  };

  load = filename:
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
