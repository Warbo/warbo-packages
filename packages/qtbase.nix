{ gcc6, isBroken, overrideCC, super }:

{
  pkg = super.qt5.qtbase.override (old: {
    stdenv = overrideCC old.stdenv gcc6;
  });

  tests = {
    nixpkgsQtBroken = isBroken super.qt5.qtbase;
  };
}
