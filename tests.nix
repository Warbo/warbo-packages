# Each package file should define its own tests. These tests don't fit in any
# particular package file.
{ lib, nixEvalOverrides, nixpkgs1709, nixpkgs1803, haskellOverride }:

with builtins;
with lib;
with {
  haskellTest = name: { extra ? {}, haskellPackages }:
    getAttr name (haskellOverride ({ inherit haskellPackages; } // extra));

  hs7103  = { haskellPackages = nixpkgs1803.haskell.packages.ghc7103; };
  hs784   = { haskellPackages = nixpkgs1709.haskell.packages.ghc784;  };
  pathfix = { extra = { filepath = true; }; };
  sybfix  = { extra = { syb      = true; }; };
  specFix = { extra = { filepath = true; extra = nixEvalOverrides; }; };
};
{
  haskell = mapAttrs haskellTest {
    genifunctors            = hs7103;
    geniplate               = hs784;
    getDeps                 = hs7103 // pathfix;
    ghc-dup                 = hs7103;
    ghc-simple              = hs7103;
    HS2AST                  = hs7103 // pathfix;
    ifcxt                   = hs7103;
    lazy-lambda-calculus    = hs7103 // sybfix;
    lazysmallcheck2012      = hs7103 // sybfix;
    mlspec-helper           = hs7103 // specFix;
    nix-eval                = hs7103 // specFix;
    runtime-arbitrary       = hs7103;
    runtime-arbitrary-tests = hs7103 // specFix;
    structural-induction    = hs784;
    tip-haskell-frontend    = hs784;
    tip-lib                 = hs784;
    tip-types               = hs7103;
  };
}
