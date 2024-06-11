{ lib, sundown }:

lib.genAttrs (import ./allowedOptions.nix) (
  o:
  sundown.override (old: {
    options = [ o ];
  })
)
