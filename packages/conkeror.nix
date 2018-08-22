{ backportOverlays, bash, callPackage, coreutils, pinGL, hasBinary, procps,
  nixpkgs1609, repo1609, runCommand, wrap, xvfb_run }:

rec {
  pkg = pinGL {
    binaries    = [ "conkeror" ];
    nixpkgsRepo = backportOverlays {
      name = "conkeror-1609";
      repo = repo1609;
    };
    pkg = nixpkgs1609.conkeror;
  };

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
            if ps -p "$PID"
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
