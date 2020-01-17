{ defaultRepo, fetchgit, repoSource ? defaultRepo }:

with rec {
  src = fetchgit {
    url    = "${repoSource}/panhandle.git";
    rev    = "45fd71d";
    sha256 = "0sg4w5vxn5p9wa5slhybp9hbqqvxg20jrh8qpa98nkx5h1vbn7lr";
  };

  pkgs = import src;
};
{
  pkg   = pkgs.panhandle.components.exes.panhandle;
  tests = builtins.trace ''
    FIXME: Disabling panhandle tests due to Nix error:
      while evaluating the attribute 'configurePhase' of the derivation 'panhandle-0.4.0.0-test-tests' at /nix/store/7ck26hd855prl2xvf213y5ia88rnbcf5-nixpkgs1909/builder/comp-builder.nix:142:3:
      while evaluating the attribute 'buildCommand' of the derivation 'panhandle-0.4.0.0-test-tests-config' at /nix/store/lj152b1wmfafjgxf6aqr5x75dqmfiw0y-nixpkgs1909/pkgs/build-support/trivial-builders.nix:7:14:
      while evaluating 'concatMapStringsSep' at /nix/store/lj152b1wmfafjgxf6aqr5x75dqmfiw0y-nixpkgs1909/lib/strings.nix:88:5, called from /nix/store/7ck26hd855prl2xvf213y5ia88rnbcf5-nixpkgs1909/builder/make-config-files.nix:74:7:
      while evaluating anonymous function at /nix/store/7ck26hd855prl2xvf213y5ia88rnbcf5-nixpkgs1909/builder/make-config-files.nix:74:37, called from undefined position:
      attribute 'configFiles' missing, at /nix/store/7ck26hd855prl2xvf213y5ia88rnbcf5-nixpkgs1909/builder/make-config-files.nix:75:16
  '';
  #pkgs.panhandle.components.tests;
}
