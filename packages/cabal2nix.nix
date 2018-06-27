# Pin cabal2nix since it's useful during evaluation, but is prone to building
# over and over for different combinations of nixpkgs, haskellPackages, etc.
# (including some quite hefty dependencies!). It also changed its calling
# convention reasonably recently, so pinning avoids the need to support both.
{ hasBinary, nixpkgs1603, withDeps }:

with rec {
  pkg    = nixpkgs1603.haskellPackages.cabal2nix;
  tested = withDeps [ (hasBinary pkg "cabal2nix") ] pkg;
};
{
  pkg   = tested;
  tests = tested;
}
