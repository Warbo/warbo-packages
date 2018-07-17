{ nixpkgs ? import <nixpkgs> { config = {}; overlays = []; } }:
nixpkgs.fetchgit {
  url    = http://chriswarbo.net/git/nix-helpers.git;
  rev    = "847cade";
  sha256 = "0cfx6f4mfh1w42rpzy9swly0n5173pvz7q24s36sfsc7yxpax3r9";
}
