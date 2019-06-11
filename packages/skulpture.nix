{ cmake, fail, fetchFromGitHub, fetchurl, findutils,
  kdelibs4 ? nixpkgs1709.kdelibs4, nixpkgs1709, qt4, qt5, stdenv, writeScript }:

with builtins;
with {
  installFiles = qt:
    with rec {
      toMove = {
        "skulpture.themerc" = "share/kde4/apps/kstyle/themes";
        "skulpture.desktop" = "share/kde4/apps/kwin";
        "skulpture.png"     = "share/kde4/apps/skulpture/pics";
        "skulptureui.rc"    = "share/kde4/apps/skulpture";
        "libskulpture.so"   = "lib/${qt}/plugins/styles";
      };

      mkCmd = file: ''
        F="${file}"
        D="${getAttr file toMove}"
        mkdir -p "$out/$D"
        FOUND=0
        while read -r GOT;
        do
        cp -rv "$GOT" "$out/$D/"
        FOUND=1
        done < <(find . -name "$F")
        [[ "$FOUND" -eq 1 ]] ||
        fail "Didn't find '$F', aborting"
      '';
    };
    concatStringsSep "\n" (map mkCmd (attrNames toMove));
};
{
  pkg = {
    skulpture-qt4 = stdenv.mkDerivation {
      name    = "skulpture-qt4";
      version = "0.2.4";
      src     = fetchurl {
        url    = "http://skulpture.maxiom.de/releases/skulpture-0.2.4.tar.gz";
        sha256 = "1s27xqd32ck09r1nnjp1pyxwi0js7a7rg2ppkvq2mk78nfcl6sk0";
      };

      buildInputs  = [ cmake fail kdelibs4 findutils qt4 ];

      installPhase = ''
        cd ..

        mkdir -p "$out/share/doc"
        for DOC in README AUTHORS COPYING NEWS NOTES BUGS
        do
          cp -v "$DOC" "$out/share/doc/"
        done

        mkdir -p "$out/share/kde4/apps/"
        cp -rv color-schemes "$out/share/kde4/apps/"

        ${installFiles "qt4"}
      '';
    };

    skulpture-qt5 = stdenv.mkDerivation rec {
      name = "skulpture-qt5";
      src = fetchFromGitHub {
        owner  = "cfeck";
        repo   = "skulpture";
        rev    = "f4f41ee";
        sha256 = "0r7123qjvkhb5qds7zyi1j1w0w2qcy59wi9zg4gvwg63j4xpiays";
      };
      preConfigure = "cd src";
      buildInputs  = [ qt5.qmake cmake kdelibs4 ];
      installPhase = ''
        cd ..
        ${installFiles "qt5"}
        echo "Patching libraries to avoid references to build dir" 1>&2
        while read -r LIB
        do
          patchelf --set-rpath "${stdenv.lib.makeLibraryPath buildInputs}" "$LIB"
        done < <(find "$out" -name "*.so")
      '';
    };
  };

  tests = {};
}
