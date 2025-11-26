{ lib, sundown }:

lib.genAttrs (import ./allowedOptions.nix) (
  o:
  sundown.override (_: {
    options = [ o ];
  })
)
