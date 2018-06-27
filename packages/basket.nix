{ kde4 ? null, nixpkgs1609 }:

with {
  pkg = kde4.basket or nixpkgs1609.kde4.basket;
};
pkg.overrideAttrs (old: {
  # Avoid problem where 'assertValidity' complains about 'kdeFrameworks' not
  # being a valid platform.
  meta = builtins.removeAttrs old.meta [ "platforms" ];
})
