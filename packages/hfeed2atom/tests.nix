{ hfeed2atom, python3, runCommand, writeScript }:
runCommand "hfeed2atom-test" {
  go = writeScript "hfeed2atom-test.py" ''
    #!${python3.withPackages (p: [ hfeed2atom ])}/bin/python3
    from hfeed2atom import hfeed2atom
    with open("${./test.html}", "r") as f:
      atom, message = hfeed2atom(
        doc=f,
        url="http://chriswarbo.net",
        atom_url="http://chriswarbo.net/blog.atom"
      )
    print(message)
  '';
} ''"$go" && mkdir "$out"''
