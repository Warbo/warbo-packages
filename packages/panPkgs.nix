# Dependencies for pandoc/panhandle/panpipe which are known to be consistent.
# Each definition was generated by cabal2nix, but we'd rather splice them in
# here instead of generating them at eval time (e.g. with hackage2nix) since
# that may require building cabal2nix, cabal-install and potentially even GHC at
# eval time, which is a bad idea (despite the results being cached).
#
# Note that these have only been tested as overrides for the package set
# nixpkgs1609.haskell.packages.ghc7103.
{ defaultRepo, latestGit, repoSource ? defaultRepo }:

self: super: {
  attoparsec = self.callPackage
    ({ mkDerivation, array, base, bytestring, containers, deepseq
     , QuickCheck, quickcheck-unicode, scientific, stdenv, tasty
     , tasty-quickcheck, text, transformers, vector
     }:
     mkDerivation {
       pname = "attoparsec";
       version = "0.13.0.2";
       sha256 = "0spcybahmqxnmngfa9cf5rh7n2r8njrgkgwb6iplmfj4ys0z7xv9";
       libraryHaskellDepends = [
         array base bytestring containers deepseq scientific text
         transformers
       ];
       testHaskellDepends = [
         array base bytestring deepseq QuickCheck quickcheck-unicode
         scientific tasty tasty-quickcheck text transformers vector
       ];
       homepage = "https://github.com/bos/attoparsec";
       description = "Fast combinator parsing for bytestrings and text";
       license = stdenv.lib.licenses.bsd3;
     })
    {};

  lazysmallcheck2012 = self.callPackage
    ({ mkDerivation, base, deepseq, ghc, stdenv, syb, template-haskell
     , uniplate
     }:
     mkDerivation {
       pname = "lazysmallcheck2012";
       version = "1.0.0";
       src = latestGit {
         url    = "${repoSource}/lazy-smallcheck-2012.git";
         stable = {
           rev    = "dbd6fba";
           sha256 = "1i3by7mp7wqy9anzphpxfw30rmbsk73sb2vg02nf1mfpjd303jj7";
           unsafeSkip = false;
        };
       };
       libraryHaskellDepends = [
         base deepseq ghc syb template-haskell uniplate
       ];
       testHaskellDepends = [
         base deepseq ghc syb template-haskell uniplate
       ];
       homepage = "https://github.com/UoYCS-plasma/LazySmallCheck2012";
       description = "Lazy SmallCheck with functional values and existentials!";
       license = stdenv.lib.licenses.bsd3;
       doCheck = false;
       doHaddock = false;
     }) {};
}