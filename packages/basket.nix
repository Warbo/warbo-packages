{ kde4 ? null, nixpkgs1609 }:

{
  pkg   = kde4.basket or nixpkgs1609.kde4.basket;
  tests = {};
}
