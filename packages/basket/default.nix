{
  kde4 ? null,
  nixpkgs1609,
}:

with builtins.tryEval (kde4.basket or nixpkgs1609.kde4.basket);
if success then
  value
else
  builtins.trace "Basket's broken (not building for Linux?) skipping" null
