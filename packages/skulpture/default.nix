{
  callPackage,
  qt5,
  qt6,
}:
with {
  skulpture = {
    qt5 = qt5.callPackage ./qt5.nix { };
    qt6 = qt6.callPackage ./qt6.nix { };
  };
};
skulpture
// {
  qt5Config = callPackage ./skulpture-config { inherit skulpture; };
}
