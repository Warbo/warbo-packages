self: super: helf: huper:

with self;
with rec {
  src = fetchFromGitHub {
    owner  = "Warbo";
    repo   = "genifunctors";
    rev    = "797482d948a00dd80f6c0236ac1d1f28fca56c68";
    sha256 = "0mfna7jsx9hkg6c4wg41bqxgphww839gx0q5amrwbl249kwn8518";
  };
};

helf.callPackage (helf.haskellSrc2nix { inherit src; name = "genifunctors"; })
                 {}
