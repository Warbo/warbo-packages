{ cmake, fail, fetchurl, findutils, kdelibs4 ? nixpkgs1709.kdelibs4,
  nixpkgs1709, nixpkgs1909, qt4, stdenv, writeScript }:

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
rec {
  pkg = {
    skulpture-qt4 = stdenv.mkDerivation {
      name    = "skulpture-qt4";
      version = "0.2.4";
      # TODO: https://github.com/nmattia/niv/issues/274
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

    mkSkulptureQt5 = { cmake, mkDerivation, qmake, qtbase }: mkDerivation rec {
      name         = "skulpture-qt5";
      src          = getSource { inherit name; };
      preConfigure = "cd src";
      buildInputs  = [ qtbase qmake cmake kdelibs4 ];
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

  tests = {
    qt5Lib = nixpkgs1909.libsForQt5.callPackage pkg.mkSkulptureQt5 {};
  };
}
