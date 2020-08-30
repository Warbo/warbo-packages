{ callPackage, getSource, lib, options ? [], stdenv }:

with builtins;
with lib;
with rec {
  allowedOptions = [
    "MKDEXT_NO_INTRA_EMPHASIS"
    "MKDEXT_TABLES"
    "MKDEXT_FENCED_CODE"
    "MKDEXT_AUTOLINK"
    "MKDEXT_STRIKETHROUGH"
    "MKDEXT_SPACE_HEADERS"
    "MKDEXT_SUPERSCRIPT"
    "MKDEXT_LAX_SPACING"
  ];

  go = { options }:
    with rec {
      whitelistedOptions = filter (o: elem o allowedOptions) options;
      sentinel = "sd_markdown_new(";
      replaced = sentinel + concatStringsSep " | " whitelistedOptions;

      setOptions = ''
        echo 'Enabling options ${toJSON whitelistedOptions}' 1>&2
        sed -e 's/${sentinel}0/${replaced}/g' -i examples/sundown.c
      '';
    };
    stdenv.mkDerivation rec {
      name         = "sundown";
      src          = getSource { inherit name; };
      buildFlags   = [ "sundown" ];
      installPhase = ''
        mkdir -p "$out/bin"
        mv sundown "$out/bin/"
      '';
      patchPhase = if whitelistedOptions == []
                      then null
                      else setOptions;
    };
};
{
  pkg   = callPackage go { inherit options; };
  tests = genAttrs allowedOptions (o: go { options = [ o ]; });
}
