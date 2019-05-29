{ nixpkgs1803, haskellOverride }:

(haskellOverride {
  haskellPackages = nixpkgs1803.haskell.packages.ghc7103;
  extra           = [
    (self: super: {
      syb = self.callHackage "syb" "0.6" {};
    })
  ];
}).lazysmallcheck2012
