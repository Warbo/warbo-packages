{ fetchurl, haskell, haskellSrc2nix, lib, nixpkgs1803, runCommand, unpack, which }:

with builtins;
with lib;
with rec {
  inherit (nixpkgs1803) haskellPackages;

  name    = "kics2-${version}";
  version = "2.0.0";
  src     = unpack (fetchurl {
    url = "https://www-ps.informatik.uni-kiel.de/kics2/download/${name}.tar.gz";
    sha256 = "0qfj51cl0qrs64yh8nh3n57cad44gn7n4x04hcvjwql1z76gv9cb";
  });

  deps = [
    "cabal-install"

    # I'm assuming we're on Linux
    "unix"

    # Taken from Makefile
    "containers"
    "directory"
    "ghc"
    "mtl"
    "network"
    "old-time"
    "parallel-tree-search"
    "process"
    "time"
    "tree-monad"

    # Needed for curry-base
    "Cabal"
    "containers"
    "directory"
    "extra"
    "filepath"
    "mtl"
    "parsec"
    "parsec"
    "pretty"
    "time"
    "transformers"

    # Needed for curry-frontend
    "Cabal"
    "containers"
    "directory"
    "extra"
    "filepath"
    "mtl"
    "network-uri"
    "pretty"
    "process"
    "set-extra"
    "transformers"
  ];

  ghc = haskellPackages.ghcWithPackages (h:
    map (p: getAttr p h) deps ++ [
      # Requires a Cabal flag to be set
      (haskell.lib.enableCabalFlag h.transformers-compat "transformers3")
    ]);

  patched = runCommand "kics2-patched" { d = src; } ''
    cp -r "$d" "$out"
    chmod -R +w "$out"

    # Patch Makefiles to be more Nix-friendly

    # Avoid impure cabal update
    sed -e 's/\$(CABAL) update/# snip/g' -i "$out/Makefile"

    # Don't try to install deps (we do this with Nix)

    sed -e 's/\$(CABAL_INSTALL)/# snip/g' -i "$out/Makefile"

    sed -e 's/\$(CABAL_INSTALL)\s*transformers-compat/# snip/g' \
        -i "$out/frontend/Makefile"
  '';

  curry-base = haskellSrc2nix {
    name = "curry-base";
    src  = "${src}/frontend/curry-base";
  };

  curry-frontend = haskellSrc2nix {
    name = "curry-frontend";
    src  = "${src}/frontend/curry-frontend";
  };

  kics2-frontend = runCommand "kics2-frontend"
    {
      cf = hsPkgs.curry-frontend;
    }
    ''
      mkdir -p "$out/bin"
      ln -s "$cf/bin/curry-frontend" "$out/bin/kics2-frontend"
    '';

  hsPkgs = haskellPackages.override (old: {
    overrides = helf: huper: {
      curry-base     = helf.callPackage curry-base {};
      curry-frontend = helf.callPackage curry-frontend {};
    };
  });

  all = {
    kernel = {
      kernelbins = {
        deps = "$(PKGDB) frontend $(CLEANCURRY) scripts copylibs copytools";
      }/*''cd src && make
         cd currytools/optimize && make''*/;

      kernellibs = "make kernellibs";
      # compile code optimization tools:
      optimize = "@cd currytools/optimize && $(MAKE)";
    };

    tools  = "make tools";
    manual = "make manual";
  };

  result = runCommand name { inherit patched; buildInputs = [ ghc which ]; } ''
    mkdir -p "$out/home"
    export HOME="$out/home"

    cp -r "$patched" ./src
    chmod -R +w ./src
    cd ./src

    echo "Starting build" 1>&2
    make "KICS2INSTALLDIR=$out/kics2"

    echo "Installing binaries" 1>&2
    mkdir -p "$out/kics2"
    for D in bin pkg
    do
      cp -r "$D" "$out/kics2"
    done

    mkdir "$out/bin"
    for F in "$out/kics2/bin"/*
    do
      NAME=$(basename "$F")
      makeWrapper "$F" "$out/bin/$NAME" --prefix PATH : "${ghc}/bin"
    done
  '';
};
trace "TODO: Tease out some more packages from the kics2 Makefiles" {
  pkg   = { inherit curry-base curry-frontend kics2-frontend; };
  tests = {};
}
