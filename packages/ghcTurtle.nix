{ haskellPackages }:

{
  pkg   = haskellPackages.ghcWithPackages (pkgs: [ pkgs.turtle ]);
  tests = {};
}
