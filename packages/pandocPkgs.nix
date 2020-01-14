# Fixed versions of pandoc, panpipe, panhandle, pandoc-citeproc
{ buildEnv, hasBinary, haskell-nix, lib, repo1909, panpipe, panhandle,
  runCommand }:

with builtins;
with lib;
with rec {
  getHackage = args:
    with { pkgs = haskell-nix { repo = repo1909; }; };
    pkgs.haskell-nix.hackage-package ({
      index-state = "2020-01-11T00:00:00Z";
      ghc         = pkgs.buildPackages.pkgs.haskell-nix.compiler.ghc865;
    } // args);

  pandoc = getHackage {
    name    = "pandoc";
    version = "2.9.1";

    # Nix's restricted evaluation mode can't fetch arbitrary things from the
    # network, like the git repo specified in pandoc's cabal.project file.
    # To work around this, haskell.nix will spot comments specifying a sha256,
    # and use that to make a fixed-output derivation (which is allowed network
    # access). Since we can't change what's in pandoc's tarball, we can use
    # this argument to override it and include a sha256 comment.
    # TODO: This is a bit hacky, as it would be nicer to just specify the sha256
    # without having to duplicate the contents of pandoc's cabal.project.
    # https://github.com/input-output-hk/haskell.nix/issues/374
    cabalProject = ''
      packages: pandoc.cabal

      package pandoc
        flags: +embed_data_files -trypandoc
        ghc-options: -j +RTS -A64m -RTS

      package pandoc-citeproc
        flags: +embed_data_files +bibutils -unicode_collation -test_citeproc -debug
        ghc-options: -j +RTS -A64m -RTS

      source-repository-package
        type: git
        location: https://github.com/jgm/pandoc-citeproc
        tag: 0.16.4.1
        --sha256: 0z7cn1lz3gjllx69q7zqv9w9f16sdcsgps02d4qs43rcyf3pjcdh
    '';
  };

  pandoc-citeproc = getHackage {
    name    = "pandoc-citeproc";
    version = "0.16.4.1";
  };
};
rec {
  pkg = buildEnv {
    name  = "pandocPkgs";
    paths = [
      pandoc.components.exes.pandoc
      pandoc-citeproc.components.exes.pandoc-citeproc
      panpipe
      panhandle
    ];
  };

  tests = genAttrs [ "pandoc" "pandoc-citeproc" "panpipe" "panhandle" ]
                   (hasBinary pkg) // {
    canPipe = runCommand "pandocPkgs-can-pipe"
      {
        buildInputs = [ pkg ];
        input       = ''
          foo

          ```{pipe="sh"}
          printf "hello"
          printf "world"
          ```

          bar
        '';
      }
      ''
        echo -e "Running simple panpipe on:\n$input" 1>&2
        GOT=$(echo "$input" | pandoc --filter panpipe -f markdown -t html)
        echo -e "Generated:\n$GOT\n" 1>&2
        echo "$GOT" | grep 'helloworld' > /dev/null ||
          fail "Didn't find 'helloworld' in:\n$GOT"
        echo "Found 'helloworld' in output, test passed" 1>&2
        mkdir "$out"
      '';

    canUnwrap = runCommand "pandocPkgs-can-unwrap"
      {
        buildInputs = [ pkg ];
        input       = "*foo* _bar_";
      }
      ''
        JSON=$(echo "$input" | pandoc -f markdown -t json)

        DATA=$(echo -e 'pre\n\n```unwrap\n'"$JSON"'\n```\n\npost')

        echo -e "Attempting to unwrap the following:\n$DATA" 1>&2
        GOT=$(echo "$DATA" | pandoc --filter panhandle -f markdown -t html)
        echo -e "Generated:\n$GOT" 1>&2

        echo "$GOT" | grep '<em>foo</em>' > /dev/null ||
          fail "Failed to find emphasis markup in:\n$GOT"
        echo "Found emphasis markup in output, test passed" 1>&2
        mkdir "$out"
      '';
  };
}
