with rec {
  inherit (builtins) getAttr toJSON trace;
  inherit (nix-helpers) gitHead nixpkgs-lib onlineCheck;
  inherit (import ./. { }) nix-helpers;
  sources = import ./nix/sources.nix;
  check = name:
    with { source = getAttr name sources; }; {
      got = source.rev;
      latest = gitHead { url = source.repo; };
    };
};
nixpkgs-lib.foldl' (result: name:
  with { inherit (check name) got latest; };
  (if onlineCheck then
    got == latest || trace (toJSON {
      inherit got latest name;
      warning = "Source repo out of date";
    }) false
  else
    trace "Offline; skipping ${name} check" true) && result) true
[ "nix-helpers" ]
