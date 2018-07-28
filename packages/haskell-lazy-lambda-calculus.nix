{ haskell, haskellOverride }:

(haskellOverride {
  haskellPackages = haskell.packages.ghc7103;
  extra           = [
    (self: super: {
      syb = self.callHackage "syb" "0.6" {};
    })
  ];
}).lazy-lambda-calculus
