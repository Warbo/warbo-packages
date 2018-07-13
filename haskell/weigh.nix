self: super: helf: huper:
with self;

helf.callPackage (self.runCabal2nix { url = "cabal://weigh-0.0.3"; }) {}
