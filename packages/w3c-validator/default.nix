{
  bash,
  openjdk,
  stdenv,
  unzip,
}:
stdenv.mkDerivation rec {
  pname = "w3c-validator";
  version = "16.1.1";
  src = builtins.fetchurl {
    sha256 = "01gyrp5fic4n95f8fvlk0b4npx762nj49w42nz3qacl11rq29r57";
    url = builtins.concatStringsSep "/" [
      "https://github.com/validator/validator/releases/download"
      version
      "vnu.jar_${version}.zip"
    ];
  };
  buildInputs = [ unzip ];
  installPhase = ''
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
