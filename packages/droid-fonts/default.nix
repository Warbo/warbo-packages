{ getSource, gnutar, runCommand, utillinux, xz }:

runCommand "droid-fonts"
  {
    zipped      = getSource { name = "droid-fonts"; };
    buildInputs = [ xz gnutar utillinux ];
  }
  ''
    D="$out/share/fonts/truetype"
    mkdir -p "$D"
    cd "$D"

    echo "Unzipping '$zipped'"
    xzcat "$zipped" | tar x

    echo "Cleaning up non-fonts"
    shopt -s nullglob
    rm *.mk
    rm *.xml
  ''
