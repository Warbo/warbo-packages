{ hasBinary, lib, pandocPkgs, runCommand, stdenv }:

lib.genAttrs
  (if stdenv.isDarwin then [] else [
    "pandoc"
    "pandoc-citeproc"
    "panpipe"
    "panhandle"
  ])
  (hasBinary pandocPkgs) // {
  canPipe = runCommand "pandocPkgs-can-pipe"
    {
      buildInputs = [ pandocPkgs ];
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
      buildInputs = [ pandocPkgs ];
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
}
