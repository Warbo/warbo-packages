{ emacs25 ? null, emacsPackagesNgGen, hasBinary, super }:

with builtins;
with rec {
  version = if emacs25 == null
               then trace (toJSON {
                      warning      = "No 'emacs25' provided, so using 'emacs'";
                      emacsVersion = super.emacs.version;
                    }) super.emacs
               else emacs25;

  # GTK crashes if X restarts, plus GTK3 is horrible and it's slow
  lucid = version.override { withGTK2 = false; withGTK3 = false; };

  pkg = (emacsPackagesNgGen lucid).emacsWithPackages (epkgs:
    with epkgs;
    with elpaPackages;
    with melpaPackages;
    [
      agda2-mode
    ]);
};
{
  inherit pkg;
  tests = hasBinary pkg "emacs";
}
