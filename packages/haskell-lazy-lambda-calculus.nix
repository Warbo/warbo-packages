{ haskell, haskellOverride, nixpkgs1809 }:

(haskellOverride {
  haskellPackages = nixpkgs1809.haskell.packages.ghc7103;
  extra           = [
    (self: super: {
      syb = self.callHackage "syb" "0.6" {};
    })
  ];
}).lazy-lambda-calculus
