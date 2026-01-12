{ amiga-launcher }:
builtins.mapAttrs (name: args: amiga-launcher ({ inherit name; } // args)) {
  SpatialHyperdrive = {
    floppies = [ "sha256-hInD99+6Qv6xpfi9t2rsFffpywV1ItT2c4ClijhThBI=" ];
  };
}
