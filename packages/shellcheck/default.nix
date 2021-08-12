# Linter for shell scripts. There is a package with this name in Nixpkgs already
# but it comes from the haskellPackages set, which is less reliable than using
# haskell-nix. I added this override to avoid broken hspec tests, but it makes
# sense to keep it even if haskellPackages.hspec gets fixed.
# TODO: Check for latest version on hackage
{ haskell-nix, stdenv, nixpkgs2105 }:

if stdenv.isDarwin
   then nixpkgs2105.shellcheck
   else (import ./components.nix { inherit haskell-nix; }).exes.shellcheck
