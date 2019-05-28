{ nixpkgs1809, haskellOverride }:

(haskellOverride {
  haskellPackages = nixpkgs1809.haskell.packages.ghc7103;
  extra           = [
    (self: super: {
      syb = self.callHackage "syb" "0.6" {};
    })
  ];
}).lazysmallcheck2012
