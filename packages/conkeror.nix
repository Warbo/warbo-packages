{ bash, callPackage, coreutils, hasBinary, procps, repo1609, runCommand, wrap,
  xvfb_run }:

rec {
  pkg = callPackage "${repo1609}/pkgs/applications/networking/browsers/conkeror"
                    {};

  tests = {
    haveBinary   = hasBinary pkg "conkeror";
    doesNotCrash = runCommand "conkeror-does-not-crash"
      {
        checker = wrap {
          name   = "conkeror-works";
          paths  = [ bash coreutils pkg procps xvfb_run ];
          script = ''
            #!/usr/bin/env bash
            set -e

            echo "Checking conkeror doesn't crash on startup" 1>&2
            timeout 30 xvfb-run conkeror "http://google.com" &
            PID="$!"

            sleep 20

            WORKS=0
            if pgrep ".*conkeror.*"
            then
              echo "works" > "$out"
            else
              echo "Conkeror process disappeared (assuming it crashed)" 1>&2
            fi

            kill "$PID" 1> /dev/null 2> /dev/null
          '';
        };
      }
      ''"$checker"'';
  };
}
