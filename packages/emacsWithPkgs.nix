{ emacs25 ? null, emacsPackagesNgGen, hasBinary, super }:

with builtins;
with rec {
  # We want the latest Emacs version, but it gets a little messy:
  # If there is no emacs25 package, use the emacs package
  version = if emacs25 == null
               then super.emacs
               # If the emacs package version is less than 25, use emacs25
               else if compareVersions super.emacs.version "25" == -1
                       then emacs25
                       # Otherwise use the (newer) emacs package
                       else super.emacs;

  # GTK crashes if X restarts, plus GTK3 is horrible and it's slow
  lucid = version.override { withGTK2 = false; withGTK3 = false; };

  pkg = (emacsPackagesNgGen lucid).emacsWithPackages (epkgs:
    with epkgs;
    with elpaPackages;
    with melpaPackages;
    []);
};
{
  inherit pkg;
  tests = hasBinary pkg "emacs";
}
