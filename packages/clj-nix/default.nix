{
  fetchTreeFromGitHub,
  graalvmPackages,
  jdk_headless,
  lib,
  newScope,
}:
with rec {
  pkgs-lib = lib;

  clj-nix = rec {
    inherit graalvmPackages jdk_headless;

    src = fetchTreeFromGitHub {
      owner = "jlesquembre";
      repo = "clj-nix";
      tree = "6c4a60056695a01f7dbfd316096270ed942023dd";
    };

    extend = _: clj-nix;

    lib =
      pkgs-lib // import "${src}/helpers.nix" { clj-nix_overlay = _: _: clj-nix; };

    pkg = p: newScope clj-nix "${src}/pkgs/${p}.nix";

    clj-builder = pkg "cljBuilder" { };
    common = pkg "common" { };
    depsLock = pkg "depsLock" { };
    fake-git = pkg "fakeGit" { };
    mk-deps-cache = pkg "mkDepsCache";
    mkCljBin = pkg "mkCljBin" { };
    mkGraalBin = pkg "mkGraalBin" { };
  };
};
clj-nix
