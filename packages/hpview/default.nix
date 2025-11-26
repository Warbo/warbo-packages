/*
  FIXME: th-lift-instances has no bounds on its text package, and seems to get
  compiled against the version provided by GHC, rather than that from the plan...

  Ready component graph:
      definite text-format-heavy-0.1.5.3-8W4NiVsN73UCTvgM7z2ssk
          depends base-4.19.2.0-213b
          depends bytestring-0.12.1.0-132b
          depends containers-0.6.8-70da
          depends data-default-0.8.0.1-6WPJcwcsqNhHGoxczNC6Yo
          depends labels-0.3.3-2jqypMTk5ujIr98XrcWJJb
          depends parsec-3.1.18.0-13nuYj2OWHCHotlQgFiuKj
          depends template-haskell-2.21.0.0-0427
          depends text-1.2.5.0-IhHhfP04M6zJHwpYyk6ajX
          depends th-lift-0.8.6-KVPb4BEIq7QDUANIXTsU8G
          depends th-lift-instances-0.1.20-37JA3AKDZpzkFWtF02Sal
          depends time-1.12.2-379e
  Warning:
      This package indirectly depends on multiple versions of the same package. This is very likely to cause a compile failure.
        package text-format-heavy (text-format-heavy-0.1.5.3) requires text-1.2.5.0-IhHhfP04M6zJHwpYyk6ajX
        package th-lift-instances (th-lift-instances-0.1.20-37JA3AKDZpzkFWtF02Sal) requires text-2.1.1-c123
        package parsec (parsec-3.1.18.0-13nuYj2OWHCHotlQgFiuKj) requires text-2.1.1-c123
  ...
  *** abort because of serious configure-time warning from Cabal
  error: builder for '/nix/store/qr2rabgpmn93fki5idwzs410bf4bl9q2-text-format-heavy-0.1.5.3.drv' failed with exit code 1;
*/
{
  #applyPatches,
  cairo,
  fetchFromGitHub,
  gobject-introspection,
  glib,
  graphene,
  gtk4,
  lib,
  nix-helpers,
  pango,
  pkg-config,
  zlib,
}:
with rec {
  /*
    formattable = nix-helpers.callCabal2nixWithPlan {
      name = "formattable";
      src = formattable-src;
    };
    formattable-src = applyPatches {
      name = "formattable-unconstrained";
      postPatch = ''sed -e 's/ *&& <.*$//g' -i formattable.cabal'';
      src = fetchFromGitHub {
        owner = "Soostone";
        repo = "formattable";
        rev = "93935b295a451c76d4cf6244c0687b595abe5893";
        sha256 = "sha256-TvdDUXkvnDC6Y79QDl48A6B1sg6KK5F42O+j+KbBw94=";
      };
    };
  */

  hpview-src = fetchFromGitHub {
    owner = "portnov";
    repo = "hpview";
    rev = "40ca4c3ad5a978130704c263a0b23207b4b876cd";
    sha256 = "sha256-Vygxc42MZmNU5GxCgZB2yts8OKe4kZIeLJDUdnurbas=";
  };

  # We can't use this result directly, since there are some naming conflicts
  inherit
    (nix-helpers.callCabal2nixWithPlan rec {
      name = "hpview";
      src = hpview-src;
      cabalPlan =
        with rec {
          sansPkgConfig = nix-helpers.cabalPlan {
            inherit name;
            cabalFile = "${src}/hpview.cabal";
          };

          withPkgConfig = sansPkgConfig.overrideAttrs (old: {
            buildInputs = (old.buildInputs or [ ]) ++ [
              gobject-introspection.dev
              gtk4.dev
              pkg-config
            ];
          });
        };
        withPkgConfig // { json = lib.importJSON withPkgConfig; };
    })
    haskellPackages
    ;

  # Resolve the naming conflicts, where packages that depend on system libraries
  # have been given Haskell libraries of the same name instead.
  inherit
    (
      (haskellPackages.extend (
        lib.composeManyExtensions [
          (_: _: {
            # Some of our dependencies need the glib and graphene system packages,
            # but are receiving the Haskell packages. Since we don't care about the
            # latter, just replace them.
            inherit glib graphene;
          })
          (_: super: {
            # System dependencies which can't just be replaced.
            cairo = super.cairo.override { inherit cairo; };
            gi-pango = super.gi-pango.override { inherit cairo pango; };
            zlib = super.zlib.override { inherit zlib; };
          })
          (self: super: {
            lift-th-instances = super.lift-th-instances.override {
              inherit (self) text;
            };
            text-format-heavy = super.text-format-heavy.override {
              inherit (self) text;
            };
          })
        ]
      ))
    )
    hpview
    ;
};
hpview
