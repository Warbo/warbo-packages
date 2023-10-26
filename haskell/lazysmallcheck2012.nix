self: super: helf: huper:

helf.callPackage (self.gitHaskell { name = "lazysmallcheck2012"; }) {
  mkDerivation = args:
    helf.mkDerivation (removeAttrs args [ "benchmarkHaskellDepends" ]);
}
