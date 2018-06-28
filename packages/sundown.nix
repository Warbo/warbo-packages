{ fetchFromGitHub, lib, options ? [], stdenv }:

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

  go = options:
    with rec {
      whitelistedOptions = filter (o: elem o allowedOptions) options;
      sentinel = "sd_markdown_new(";
      replaced = sentinel + concatStringsSep " | " whitelistedOptions;

      setOptions = ''
        echo 'Enabling options ${toJSON whitelistedOptions}' 1>&2
        sed -e 's/${sentinel}0/${replaced}/g' -i examples/sundown.c
      '';
    };
    stdenv.mkDerivation {
      name = "sundown";
      src  = fetchFromGitHub {
        owner  = "vmg";
        repo   = "sundown";
        rev    = "37728fb";
        sha256 = "0znnw7dkyir3a78hx8sb29dc4fj3wb3alv5w0iwasfc2ir0kcd8s";
      };
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
  def   = go options;
  tests = genAttrs allowedOptions (o: go [ o ]);
}
