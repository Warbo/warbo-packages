self: super: helf: huper:

with self;
with builtins;
with rec {
  typesSrc = runCommand "mk-types-src" { inherit unstableTipSrc; } ''
    #!${bash}/bin/bash
    cp -r "$unstableTipSrc/tip-types" "$out"
  '';
};

helf.callPackage (helf.haskellSrc2nix {
                   name = "tip-types";
                   src  = typesSrc;
                 }) {}
