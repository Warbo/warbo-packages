{ dreamcast-launcher }:
builtins.mapAttrs (name: discs: dreamcast-launcher { inherit name discs; }) {
  "House Of The Dead 2"."HouseOfTheDead2.cdi" =
    "f1220ed2cb3dce3bb7c2b93e9b6a850a0ea7604667c029aa55ea490cec875e6a00511";

  "Resident Evil Code Veronica" = [
    {
      "Disc1.cdi" =
        "f1220aeab6d84bf28b2dbef2d7c00b0e0a33b84b17be9e80dc9d81afd6061d010c2d5";
    }
    {
      "Disc2.cdi" =
        "f1220ac70ac1bb129e71c3c72f0a536693b4afc622acff58664fdaf38a340a8a33b5b";
    }
  ];

  "Sonic Adventure"."SonicAdventure.cdi" =
    "f1220105b9a8849feeabf4b7b00a6f5d101d18789af82dfeba407952d884a726b9533";

  "Sonic Adventure 2"."SonicAdventure2.cdi" =
    "f12202c4525a0e5245dc7c31f022e339f07be3508db0d702d87a52fccc4850a7582c4";
}
