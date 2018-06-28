# Fixed versions of pandoc, panpipe, panhandle, pandoc-citeproc and dependencies
{ buildEnv, hasBinary, lib, nixpkgs1609, panhandle, panpipe, runCommand,
  writeScript }:

with builtins;
with lib;
rec {
  pkg = buildEnv {
    name  = "pandocPkgs";
    paths = with nixpkgs1609; [
      haskellPackages.pandoc-citeproc pandoc panhandle panpipe
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
