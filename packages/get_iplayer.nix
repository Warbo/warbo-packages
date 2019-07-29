# Updated get_iplayer
{ buildEnv, cacert, fetchurl, ffmpeg, hasBinary, lib, onlineCheck,
  perlPackages, runCommand, stdenv, super, wget, xidel }:

with builtins;
with lib;
with rec {
  # Update this as needed
  tag    = "v3.20";
  sha256 = "0p9mxg79qq0x4fn32brh5iam217751mgvpx3bk3dhdzjsrmiqv99";

  src    = versionTest fetchurl {
    inherit sha256;
    url = "https://github.com/get-iplayer/get_iplayer/archive/${tag}.tar.gz";
  };

  latestVersion = import (runCommand "latest-get_iplayer.nix"
    {
      __noChroot  = true;
      buildInputs = [ wget xidel ];
      cacheBuster = toString currentTime;
      expr        = concatStringsSep "/" [
        ''//a[contains(text(), "Latest release")]''
        ".."
        ".."
        ''/a[contains(@href, "releases/tag")]''
        "text()"
      ];

      SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";

      url = "https://github.com/get-iplayer/get_iplayer/releases";
    }
    ''
      wget -q -O releases.html "$url" || {
        echo "Couldn't download releases page, skipping test" 1>&2
        echo '"0"' > "$out"
      }

      LATEST=$(xidel - -q -e "$expr" < releases.html)
      echo "\"$LATEST\"" > "$out"
    '');

  versionTest = if onlineCheck && compareVersions tag latestVersion == -1
                   then trace (toJSON {
                     inherit latestVersion tag;
                     WARNING = "Newer get_iplayer available";
                   })
                   else (x: x);

  get_iplayer_real = { ffmpeg, get_iplayer, perlPackages }:
    stdenv.lib.overrideDerivation get_iplayer
      (oldAttrs : {
        inherit src;
        name                  = "get_iplayer-${tag}";
        propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [
          perlPackages.LWPProtocolHttps
          perlPackages.XMLSimple
          ffmpeg
        ];
      });

  mkPkg = { ffmpeg, get_iplayer, perlPackages }: buildEnv {
    name  = "get_iplayer";
    paths = [
      (get_iplayer_real { inherit ffmpeg get_iplayer perlPackages; })
      ffmpeg
      perlPackages.LWPProtocolHttps
      perlPackages.XMLSimple
    ];
  };
};
rec {
  # Some dependencies seem to be missing, so bundle them in with get_iplayer
  pkg = makeOverridable mkPkg {
    inherit (super) ffmpeg get_iplayer perlPackages;
  };

  tests = hasBinary pkg "get_iplayer";
}
