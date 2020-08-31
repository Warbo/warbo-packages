with {
  helpers = import ./packages/nix-helpers {};
};
(import helpers.repoLatest {
  config   = {};
  overlays = [ (import ./overlay.nix) ];
}).warbo-packages
