# aspell needs a dict in order to be useful, but it can only use one at a time.
# Due to https://github.com/NixOS/nixpkgs/issues/1000 we should also make sure
# we're pointing it at the right dict via ~/.aspell.conf
{ aspell, aspellDicts, bash, buildEnv, fail, lib, mkBin, runCommand }:

with builtins;
with rec {
  mkPkg = { dict }:
    with {
      real = buildEnv {
        name  = "aspellWithDict";
        paths = [ aspell (getAttr dict aspellDicts) ];
      };
    };
    mkBin {
      name  = "aspell";
      paths = [ bash ];
      vars  = {
        inherit real;
        ASPELL_CONF = "dict-dir ${real}/lib/aspell";
      };
      script = ''
        #!/usr/bin/env bash
        exec "$real"/bin/aspell -d "$real"/lib/aspell "$@"
      '';
    };
};
rec {
  pkg   = lib.makeOverridable mkPkg { dict = "en"; };
  tests = {
    haveEn = runCommand "aspell-uses-dict"
      { buildInputs = [ fail pkg ]; }
      ''
        GOT=$(aspell dicts) ||
          fail "aspell failed $GOT"

        echo "$GOT" | grep 'en_GB' > /dev/null ||
          fail "No en_GB in aspell output $GOT"

        mkdir "$out"
      '';
  };
}
