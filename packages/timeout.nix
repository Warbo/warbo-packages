{ attrsToDirs', bash, coreutils, fetchFromGitHub, hasBinary, perl, procps,
  runCommand, wrap }:

with rec {
  src = fetchFromGitHub {
    owner  = "pshved";
    repo   = "timeout";
    rev    = "1ce1006";
    sha256 = "0nsv05kg22l6w0v885nli2hc7r6vi0jrfhb98jyfq38qaad5y78c";
  };

  patched = runCommand "timeout-patched" { inherit src; } ''
    cp -r "$src" "$out"
    chmod -R +w "$out"
    sed -e 's@/usr/bin/perl@${perl}/bin/perl@g' -i "$out/timeout"
  '';
};
rec {
  pkg = attrsToDirs' "timeout" {
    bin = rec {
      timeout = wrap {
        name  = "timeout";
        file  = "${patched}/timeout";
        paths = [ coreutils perl procps ];
      };

      # Wrapper for timeout, which provides sensible defaults
      withTimeout = wrap {
        name   = "withTimeout";
        paths  = [ bash ];
        script = ''
          #!${bash}/bin/bash
          TIME_OPT=""
          MEM_OPT=""
          [[ -z "$MAX_SECS" ]] || TIME_OPT="-t $MAX_SECS"
          [[ -z "$MAX_KB"   ]] ||  MEM_OPT="-m $MAX_KB"
          "${timeout}" -c --no-info-on-success $TIME_OPT $MEM_OPT "$@"
        '';
      };
    };
  };

  tests = hasBinary pkg "withTimeout";
}
