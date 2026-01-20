{ ps1-launcher }:
builtins.mapAttrs (name: discs: ps1-launcher { inherit name discs; }) {
  "Crash Bandicoot"."disc.bin" =
    "mEiA11Lg3EIrcTFMTpFwPIDqna8CRGHMgTpCFEhhzeeuY7A";
  "Oddworld Abes Oddysee"."disc.bin" =
    "mEiAYvzIIgJgQEadVAmNSrceB0IEOTjznbMBPUcqYnTgDQA";
}
