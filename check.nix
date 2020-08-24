with rec {
  inherit (builtins) getAttr toJSON trace;
  inherit (nix-helpers) gitHead nixpkgsLatest onlineCheck;
  nix-helpers = import sources.nix-helpers.outPath;
  sources     = import ./nix/sources.nix;
  check       = name:
    with { source = getAttr name sources; };
    { got = source.rev; latest = gitHead { url = source.repo; }; };
};
nixpkgsLatest.lib.foldl' (result: name:
                           with check name;
                           (if onlineCheck
                               then got == latest || trace (toJSON {
                                 inherit got latest name;
                                 warning = "Source repo out of date";
                               }) false
                               else trace "Offline; skipping ${name} check" true) && result)
                           true
                           [ "nix-helpers" ]
