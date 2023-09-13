{ nix-helpers ? import ./nix-helpers { }, nixpkgs ? nix-helpers.nixpkgs
, nixpkgs-lib ? nix-helpers.nixpkgs-lib }:

with rec {
  inherit (builtins) removeAttrs;
  inherit (nixpkgs-lib) mapAttrs;
  inherit (nix-helpers) nixDirsIn nixFilesIn;

  util = mapAttrs call (nixFilesIn ../util);

  # Like callPackage, but allows args to come from extraArgs
  call = _: f: nixpkgs.newScope extraArgs f { };

  extraArgs = nix-helpers // util // {
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
