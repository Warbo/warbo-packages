{ getSource, mf2py, python3Packages }:

python3Packages.callPackage
  ({ beautifulsoup4, buildPythonPackage }: buildPythonPackage rec {
    name                  = "hfeed2atom";
    src                   = getSource { inherit name; };
    propagatedBuildInputs = [ beautifulsoup4 mf2py ];
    doCheck               = false;
    postUnpack            = ''
      # Avoid circular import (using Python2 imports in Python3?)
      sed -e 's/from hfeed2atom/from .hfeed2atom/g' \
          -i hfeed2atom-src/hfeed2atom/__init__.py
    '';
  })
  {}
