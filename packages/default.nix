{ haskell, haskellPackages, lib, newScope, super }:

with rec {
  inherit (builtins) attrNames getAttr readDir removeAttrs;
  inherit (lib) filter fold hasSuffix mapAttrs removeSuffix;
  inherit (nix-helpers) nixDirsIn nixFilesIn;

  nix-helpers = import ./packages/nix-helpers.nix {};

  util = mapAttrs (_: call) (nixFilesIn ./util);

  # Like callPackage, but allows args to come from extraArgs
  call = _: f: newScope extraArgs f {};

  extraArgs = nix-helpers // util // {
    # Useful for overriding things
    inherit extraArgs nix-helpers super;
  };

  load = filename: mapAttrs call (nixDirsIn {
    inherit filename;
    dir = ./.;
  });

  packages = load "default.nix";
  tests    = load "tests.nix";
};
with fold mkPkg { pkgs = {}; tests = call ./tests.nix; } fileNames;
with rec {
  warbo-packages = pkgs // {
    inherit warbo-packages;
    warbo-packages-tests = tests;
  };
};
removeAttrs warbo-packages [ "nix-helpers" ]
