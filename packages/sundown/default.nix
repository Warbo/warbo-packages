{ getSource, lib, options ? [ ], stdenv }:

with rec {
  inherit (builtins) elem toJSON;
  inherit (lib) concatStringsSep filter;
  allowedOptions = import ./allowedOptions.nix;
  whitelistedOptions = filter (o: elem o allowedOptions) options;
  sentinel = "sd_markdown_new(";
  replaced = sentinel + concatStringsSep " | " whitelistedOptions;

  setOptions = ''
    echo 'Enabling options ${toJSON whitelistedOptions}' 1>&2
    sed -e 's/${sentinel}0/${replaced}/g' -i examples/sundown.c
  '';
};
stdenv.mkDerivation rec {
  name = "sundown";
  src = getSource { inherit name; };
  buildFlags = [ "sundown" ];
  installPhase = ''
    mkdir -p "$out/bin"
    mv sundown "$out/bin/"
  '';
  patchPhase = if whitelistedOptions == [ ] then null else setOptions;
}
