{ defaultRepo, fetchgit, repoSource ? defaultRepo }:

with rec {
  src = fetchgit {
    url    = "${repoSource}/panpipe.git";
    rev    = "24734f6";
    sha256 = "178xs0h29ygj3f1vs8p9gb278816zi1gmnks7j7bgdlx7c7ymd3v";
  };

  pkgs = import src;
};
{
  pkg   = pkgs.panpipe.components.exes.panpipe;
  tests = builtins.trace ''
    FIXME: Disabling panpipe tests due to Nix error:
      while evaluating the attribute 'configurePhase' of the derivation 'panhandle-0.4.0.0-test-tests' at /nix/store/7ck26hd855prl2xvf213y5ia88rnbcf5-nixpkgs1909/builder/comp-builder.nix:142:3:
      while evaluating the attribute 'buildCommand' of the derivation 'panhandle-0.4.0.0-test-tests-config' at /nix/store/lj152b1wmfafjgxf6aqr5x75dqmfiw0y-nixpkgs1909/pkgs/build-support/trivial-builders.nix:7:14:
      while evaluating 'concatMapStringsSep' at /nix/store/lj152b1wmfafjgxf6aqr5x75dqmfiw0y-nixpkgs1909/lib/strings.nix:88:5, called from /nix/store/7ck26hd855prl2xvf213y5ia88rnbcf5-nixpkgs1909/builder/make-config-files.nix:74:7:
      while evaluating anonymous function at /nix/store/7ck26hd855prl2xvf213y5ia88rnbcf5-nixpkgs1909/builder/make-config-files.nix:74:37, called from undefined position:
      attribute 'configFiles' missing, at /nix/store/7ck26hd855prl2xvf213y5ia88rnbcf5-nixpkgs1909/builder/make-config-files.nix:75:16
  '';
  #pkgs.panpipe.components.tests;
}
