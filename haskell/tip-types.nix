self: _: helf: _:

with self;
with builtins;
with rec {
  typesSrc = runCommand "mk-types-src" { inherit unstableTipSrc; } ''
    #!${bash}/bin/bash
    cp -r "$unstableTipSrc/tip-types" "$out"
  '';
};

helf.callPackage (haskellSrc2nix {
  name = "tip-types";
  src = typesSrc;
}) { }
