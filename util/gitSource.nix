# Pull the given name from niv's sources.nix, unless an alternative repo has
# been configures, using the name 'repoSource'
{ die, repoSource ? null, warbo-packages-sources }:

{ name }:
  with rec {
    inherit (builtins) elem getAttr;
    source = getAttr name warbo-packages-sources;
  };
  assert elem source.type [ "git" "github" ] || die {
    inherit name;
    inherit (source) type;
    error = "gitSource only works for git/github sources (try getSource?)";
  };
  if repoSource == null
     then source
     else builtins.fetchgit {
       inherit (source) rev;
       url = repoSource + "/" + baseNameOf source.repo;
     }
