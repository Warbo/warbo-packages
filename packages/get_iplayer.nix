# Updated get_iplayer
{ buildEnv, cacert, fetchurl, ffmpeg, hasBinary, lib, perlPackages, runCommand,
  stdenv, super, wget, xidel }:

with lib;
with rec {
  # Update this as needed
  tag    = "v3.20";
  sha256 = "0p9mxg79qq0x4fn32brh5iam217751mgvpx3bk3dhdzjsrmiqv99";

  src    = fetchurl {
    inherit sha256;
    url = "https://github.com/get-iplayer/get_iplayer/archive/${tag}.tar.gz";
  };

  versionTest = runCommand "latest-get_iplayer"
    {
      __noChroot  = true;
      buildInputs = [ wget xidel ];
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
        mkdir "$out"
      }

      LATEST=$(xidel - -q -e "$expr" < releases.html)
      if [[ "x$LATEST" = "x${tag}" ]]
      then
        echo "Latest get_iplayer is '$LATEST', as expected" 1>&2
        mkdir "$out"
      else
        echo "Update get_iplayer! Have '${tag}', but '$LATEST' is out" 1>&2
        exit 1
      fi
    '';

  get_iplayer_real = { ffmpeg, get_iplayer, perlPackages }:
    stdenv.lib.overrideDerivation get_iplayer
      (oldAttrs : {
        inherit src versionTest;
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
