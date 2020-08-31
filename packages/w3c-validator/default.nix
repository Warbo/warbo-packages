{ bash, openjdk, stdenv, unzip, warbo-packages-sources }:

with rec {
  name   = "w3c-validator";
  source = builtins.getAttr name warbo-packages-sources;
};
stdenv.mkDerivation {
  inherit name;
  inherit (source) version;
  src                   = source.outPath;
  buildInputs           = [ unzip ];
  propagatedBuildInputs = [ openjdk bash ];
  installPhase          = ''
    mkdir -p "$out/lib/";
    cp -v vnu.jar "$out/lib/"

    mkdir -p "$out/share";
    for F in vnu.jar.* LICENSE *.md *.html
    do
      cp -v "$F" "$out/share"
    done

    mkdir -p "$out/bin/";
    cat <<EOF > "$out/bin/w3c-validator"
    #!${bash}/bin/bash
    ${openjdk}/bin/java -Xss512k -jar "$out/lib/vnu.jar" "$@"
    EOF

    chmod +x "$out/bin/w3c-validator"
  '';
}
