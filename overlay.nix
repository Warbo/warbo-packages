self: super:

with builtins;
with super.lib;
with rec {
  # Whilst the values in our result set can depend on self, the names must not
  # since that would cause an infinite recursion. Hence we can't just use
  # 'attrNames pkgFiles' since that would depend on self.
  fileNames = map (removeSuffix ".nix") (attrNames (readDir ./packages));
  pkgFiles  = self.nixFilesIn ./packages;
};
with fold (name: previous:
            with rec {
              defs  = self.callPackage (getAttr name pkgFiles) {};

              pkg   = { "${name}" = defs.pkg or defs; };

              tests = if defs ? tests
                         then { "${name}" = defs.tests; }
                         else {};
            };
            {
              pkgs  = previous.pkgs  // pkg;
              tests = previous.tests // tests;
            })
          { pkgs = {}; tests = {}; }
          fileNames;
pkgs // {
  warbo-packages-tests = assert self ? nixFilesIn || abort ''
    Overlay from http://chriswarbo.net/git/warbo-packages relies on overlay from
    http://chriswarbo.net/git/nix-helpers being loaded first.'';
    tests;
}
