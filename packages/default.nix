{ lib, newScope, self, super }:

with rec {
  inherit (builtins) removeAttrs;
  inherit (lib) mapAttrs;
  inherit (nix-helpers) nixDirsIn nixFilesIn;

  nix-helpers = import ./nix-helpers {};

  util = mapAttrs call (nixFilesIn ../util);

  # Like callPackage, but allows args to come from extraArgs
  call = _: f: newScope extraArgs f {};

  extraArgs = nix-helpers // util // {
    # Useful for overriding things
    inherit extraArgs nix-helpers self super;
  };

  load = filename: mapAttrs call (nixDirsIn {
    inherit filename;
    dir = ./.;
  });

  packages = load "default.nix";
  tests    = load "tests.nix";
};
with rec {
  warbo-packages = packages // {
    inherit warbo-packages;
    warbo-packages-tests = tests;
  };
};
removeAttrs warbo-packages [ "nix-helpers" ]
